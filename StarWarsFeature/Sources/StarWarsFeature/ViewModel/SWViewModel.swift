import SwiftUI
import Combine

extension SWViewModel {
	public enum SWAction: Hashable {
		case onAppear
	}
}

@MainActor
public final class SWViewModel: ObservableObject {
	@Published public var model: PlanetsResponse = .noop
	@Published public var error: SWError?

	public let action: PassthroughSubject<SWAction, Never> = .init()
	private(set) var cancellables: Set<AnyCancellable> = []
	
	private let service: SWPlanetsProvider
	
	public init(service: SWPlanetsProvider = SWService.live) {
		self.service = service
		
		setupListeners()
	}
	
	private func setupListeners() {
		action
			.sink { [weak self] incomingAction in
				guard let self else { return }
				
				switch incomingAction {
				case .onAppear:
					Task {
						do {
							self.model = try await self.service.fetchPlanets()
						} catch {
							self.error = SWError.message(error.localizedDescription)
						}
					}
				}
			}
			.store(in: &cancellables)
	}
}
