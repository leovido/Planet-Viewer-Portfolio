import SwiftUI
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
	@Published public var selectedPlanetDetail: PlanetDetail?
	@Published public var error: SWError?
	@Published public var isLoading: Bool = false
	
	public var artificialDelay: Duration = .zero
	
	public var planetListItems: [PlanetListItem] {
		model.planets.map { PlanetListItem(from: $0) }
	}
	
	private var inFlightTasks: [SWAction: Task<Void, Never>] = [:]
	private let service: SWPlanetsProvider
	
	deinit {
		inFlightTasks.forEach { $0.value.cancel() }
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
	}
	
	public func dispatch(_ action: SWAction) {
		Task { @MainActor in
			switch action {
			case .onAppear, .didTapPill(0):
				handleOnAppear()
			case .refresh:
				handleRefresh()
			case let .selectPlanet(planetId):
				handleSelectPlanet(planetId)
			case .didTapPill(1):
				break
			case .didTapPill:
				fatalError("not implemented")
			}
		}
	}
	
	// MARK: - Action Handlers
	private func handleOnAppear() {
		isLoading = true

		fetchPlanets(.onAppear)
	}
	
	private func handleSelectPlanet(_ planetId: String) {
		selectPlanet(withId: planetId)
	}
	
	private func handleRefresh() {
		fetchPlanets(.refresh)
	}
	
	// MARK: - Methods
	
	func selectPlanet(withId id: String) {
		if let planet = model.planets.first(where: { $0.id == id }) {
			selectedPlanetDetail = PlanetDetail(from: planet)
		}
	}
	
	private func fetchPlanets(_ action: SWAction) {
		inFlightTasks[action]?.cancel()
		inFlightTasks.removeValue(forKey: .onAppear)
		
		isLoading = action == .onAppear // show loading indicator only on .onAppear, refresh has its own progress view
		error = nil
		
		let task = Task { [weak self] in
			guard let self = self else { return }
			
			do {
				let response = try await self.service.fetchPlanets()
				
				if Task.isCancelled { return }
				
				self.model = response
				self.error = nil
			} catch {
				if !Task.isCancelled {
					self.error = SWError.message(error.localizedDescription)
				}
			}
			
			if !Task.isCancelled {
				self.isLoading = false
				self.inFlightTasks.removeValue(forKey: .onAppear)
			}
		}
		
		inFlightTasks[.onAppear] = task
	}
}
