import SwiftUI
import Combine
import Foundation

extension SWViewModel {
	public enum SWAction: Hashable {
		case onAppear
		case refresh
		case selectPlanet(String)
		case didTapPill(Int)
	}
}

@MainActor
public final class SWViewModel: ObservableObject {
	@Published public var model: SWPlanetsResponse = .noop
	@Published public var planetListItems: [PlanetListItem] = []
	@Published public var selectedPlanetDetail: PlanetDetail?
	
	@Published public var error: SWError?
	@Published public var isLoading: Bool = false
	
	private var inFlightTasks: [SWAction: Task<Void, Never>] = [:]

	public let action: PassthroughSubject<SWAction, Never> = .init()
	private(set) var cancellables: Set<AnyCancellable> = []
	
	private let service: SWPlanetsProvider
	
	deinit {
		inFlightTasks.forEach({
			$1.cancel()
		})
	}
	
	public init(
		model: SWPlanetsResponse = .noop,
		error: SWError? = nil,
		isLoading: Bool = false,
		service: SWPlanetsProvider = SWService.live
	) {
		self.model = model
		self.error = error
		self.isLoading = isLoading
		self.service = service
		
		setupActionHandlers()
	}
	
	private func setupActionHandlers() {
		let sharedAction = action.share()
		
		sharedAction
			.filter { $0 == .onAppear || $0 == .didTapPill(0) }
			.handleEvents(receiveRequest: { [weak self] _ in
				self?.isLoading = true
			})
			.sink { [weak self] _ in self?.handleOnAppear() }
			.store(in: &cancellables)
		
		sharedAction
			.filter { if case .selectPlanet = $0 { return true } else { return false } }
			.sink { [weak self] action in
				if case let .selectPlanet(planet) = action {
					self?.handleSelectPlanet(planet)
				}
			}
			.store(in: &cancellables)
			
		sharedAction
			.filter { if case .refresh = $0 { return true } else { return false } }
			.handleEvents(receiveRequest: { [weak self] _ in
				self?.isLoading = true
			})
			.sink { [weak self] _ in self?.handleRefresh() }
			.store(in: &cancellables)
	}
	
	// MARK: - Action Handlers
	private func handleOnAppear() {
		fetchPlanets()
	}
	
	private func handleSelectPlanet(_ planetId: String) {
		selectPlanet(withId: planetId)
	}
	
	private func handleRefresh() {
		fetchPlanets()
	}
	
	// MARK: - Methods
	
	func selectPlanet(withId id: String) {
		if let planet = model.planets.first(where: { $0.id == id }) {
			selectedPlanetDetail = PlanetDetail(from: planet)
		}
	}
	
	private func fetchPlanets() {
		inFlightTasks[.onAppear]?.cancel()
		inFlightTasks[.onAppear] = Task {
			do {
				self.model = try await self.service.fetchPlanets()
				self.planetListItems = self.model.planets.map { PlanetListItem(from: $0) }

				self.error = nil
			} catch {
				self.error = SWError.message(error.localizedDescription)
			}
			
			self.isLoading = false
		}
	}
}
