import SwiftUI
import Foundation

extension SWPlanetViewModel {
	public enum SWAction: Hashable {
		case onAppear
		case refresh
		case selectPlanet(String)
		case didTapPill(Int)
	}
}

@MainActor
public final class SWPlanetViewModel: ObservableObject {
	@Published public var model: SWPlanetsResponse = .noop
	@Published public var selectedPlanetDetail: PlanetDetail?
	@Published public var error: SWError?
	@Published public var isLoading: Bool = false
	
	public var planetListItems: [PlanetListItem] {
		model.planets.map { PlanetListItem(from: $0.properties) }
	}
	
	private var inFlightTasks: [SWAction: Task<Void, Never>] = [:]
	private let service: SWPlanetsProvider
	
	deinit {
		// Ensure all tasks are cancelled when view model is deallocated
		inFlightTasks.forEach { $0.value.cancel() }
		inFlightTasks.removeAll()
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
	
	public func dispatch(_ action: SWAction) async {
		switch action {
		case .onAppear, .didTapPill(0):
			await handleOnAppear()
		case .refresh:
			await handleRefresh()
		case let .selectPlanet(planetId):
			handleSelectPlanet(planetId)
		case .didTapPill(1):
			break
		case .didTapPill:
			fatalError("not implemented")
		}
	}
	
	// MARK: - Action Handlers
	private func handleOnAppear() async {
		isLoading = true
		await fetchPlanets(.onAppear)
	}
	
	private func handleSelectPlanet(_ planetId: String) {
		selectPlanet(withId: planetId)
	}
	
	private func handleRefresh() async {
		await fetchPlanets(.refresh)
	}
	
	private func selectPlanet(withId id: String) {
		if let planet = model.planets.first(where: { $0.uid == id }) {
			selectedPlanetDetail = PlanetDetail(from: planet.properties)
		}
	}
	
	private func fetchPlanets(_ action: SWAction) async {
		await withTask(for: action, showLoading: action == .onAppear || action == .refresh) {
			let response = try await self.service.fetchPlanets()
			self.model = response
		}
	}
}

extension SWPlanetViewModel {
	private func withTask(
		for action: SWAction,
		showLoading: Bool = false,
		operation: @escaping () async throws -> Void
	) async {
		error = nil
		
		if let existingTask = inFlightTasks[action] {
			existingTask.cancel()
			inFlightTasks.removeValue(forKey: action)
		}
		
		let task = Task { [weak self] in
			guard let self = self else { return }
			
			do {
				if showLoading {
					self.isLoading = true
				}
				
				try await operation()
				
				guard !Task.isCancelled else {
					return
				}
				
				self.isLoading = false
				
			} catch {
				guard !Task.isCancelled else {
					return
				}
				
				self.error = SWError.message(error.localizedDescription)
				self.isLoading = false
			}
		}
		
		inFlightTasks[action] = task
		// Wait for task completion and then remove from dictionary
		await task.value
		inFlightTasks.removeValue(forKey: action)
	}
}

