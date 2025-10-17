import Combine
import SwiftUI
import Foundation

extension SWPeopleViewModel {
	public enum Action: Hashable {
		case onAppear
		case refresh
		case selectPerson(String)
		case didTapPill(Int)
	}
}

@MainActor
public final class SWPeopleViewModel: SWViewModelProtocol, ObservableObject {
	@Published public var model: SWPeopleResponse = .noop
	@Published public var selectedPersonDetail: PersonDetailModel?
	@Published public var error: SWError?
	@Published public var isLoading: Bool = false
	
	@Published public var peopleListItems: [PersonListItem] = []
	
	var inFlightTasks: [Action: Task<Void, Never>] = [:]
	private let service: SWAPIProvider
	
	private(set) var cancellables: Set<AnyCancellable> = []
	
	deinit {
		inFlightTasks.forEach { $0.value.cancel() }
		inFlightTasks.removeAll()
	}
	
	public init(
		model: SWPeopleResponse = .noop,
		error: SWError? = nil,
		isLoading: Bool = false,
		service: SWAPIProvider = SWService.live
	) {
		self.model = model
		self.error = error
		self.isLoading = isLoading
		self.service = service
		self.peopleListItems = model.results.map({ PersonListItem(from: $0.properties) })
		
		$model
			.receive(on: DispatchQueue.main)
			.sink { newModel in
				self.peopleListItems = newModel.results.map({ PersonListItem(from: $0.properties) })
			}
			.store(in: &cancellables)
	}
	
	public func dispatch(_ action: Action) async {
		switch action {
		case .onAppear, .didTapPill(0):
			await handleOnAppear()
		case .refresh:
			await handleRefresh()
		case let .selectPerson(personId):
			handleSelectPerson(personId)
		case .didTapPill(1):
			await fetchPeople(.didTapPill(1))
		case .didTapPill:
			fatalError("not implemented")
		}
	}
	
	// MARK: - Action Handlers
	private func handleOnAppear() async {
		isLoading = true
		await fetchPeople(.onAppear)
	}
	
	private func handleSelectPerson(_ personId: String) {
		selectPerson(withId: personId)
	}
	
	private func handleRefresh() async {
		await fetchPeople(.refresh)
	}
	
	private func selectPerson(withId id: String) {
		if let person = model.results.first(where: { $0.id == id }) {
			selectedPersonDetail = PersonDetailModel(from: person.properties)
		}
	}
	
	private func fetchPeople(_ action: Action) async {
		await withTask(for: action, showLoading: action == .onAppear) {
			let response = try await self.service.fetchPeople()
			self.model = response
		}
	}
}
