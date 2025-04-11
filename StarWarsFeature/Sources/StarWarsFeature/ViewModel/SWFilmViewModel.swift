import SwiftUI

@MainActor
public final class SWFilmViewModel: ObservableObject {
	@Published public var film: SWFilmResponse = .noop
	
	private let service: SWPlanetsProvider
	
	public init(service: SWPlanetsProvider = SWService.live) {
		self.service = service
	}
	
	public func fetchFilms() async throws {
		do {
			film = try await service.fetchFilms()
		} catch {
			dump(error)
		}
	}
}
