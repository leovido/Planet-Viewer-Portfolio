import SwiftUI

extension SWFilmViewModel {
	public enum SWAction: Hashable {
		case onAppear
	}
}

@MainActor
public final class SWFilmViewModel: ObservableObject, SWViewModelProtocol {
	@Published public var selectedPersonDetail: PersonDetailModel?
	@Published public var filmListItems: [FilmListItem] = []

	@Published public var isLoading: Bool = false
	@Published public var error: SWError?
	
	var inFlightTasks: [SWAction: Task<Void, Never>] = [:]
	private let service: SWAPIProvider
	
	deinit {
		inFlightTasks.forEach { $0.value.cancel() }
		inFlightTasks.removeAll()
	}
	
	public init(
		isLoading: Bool = false,
		error: SWError? = nil,
		service: SWAPIProvider = SWService.live
	) {
		self.service = service
		self.isLoading = isLoading
		self.error = error
	}
	
	public func dispatch(_ action: SWAction) async {
		switch action {
		case .onAppear:
			do {
				try await handleOnAppear()
			} catch {
				dump(error)
			}
		}
	}
	
	public func handleOnAppear() async throws {
		try await fetchFilms()
	}
	
	public func fetchFilms() async throws {
		do {
			let response = try await service.fetchFilms()
			self.filmListItems = response.result.map({ FilmListItem(from: $0) })
		} catch {
			self.error = .message(error.localizedDescription)
		}
	}
}
