import SwiftUI

@MainActor
public final class SWFilmViewModel: ObservableObject {
	@Published public var film: SWFilmResponse = .noop
	
	@Published public var isLoading: Bool = false
	@Published public var error: Error?

	private let service: SWAPIProvider
	
	public init(service: SWAPIProvider = SWService.live,
							film: SWFilmResponse = .noop,
							isLoading: Bool = false,
							error: Error? = nil) {
		self.service = service
		self.film = film
		self.isLoading = isLoading
		self.error = error
	}
	
	public func fetchFilms() async throws {
		isLoading = true
		error = nil
		do {
			film = try await service.fetchFilms()
		} catch {
			self.error = error
		}
		
		isLoading = false
	}
}
