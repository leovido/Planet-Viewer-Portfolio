import XCTest
@testable import StarWarsFeature

@MainActor
final class SWPeopleViewModelTests: XCTestCase {
	var viewModel: SWPeopleViewModel!
	
	override func setUp() async throws {
		viewModel = .init(service: SWService.test)
	}
	
	override func tearDown() async throws {
		viewModel = nil
	}
	
	func testOnAppear() async throws {
		XCTAssertEqual(viewModel.model.results.count, 0)
		XCTAssertEqual(viewModel.isLoading, false)
		await viewModel.dispatch(.onAppear)
	}
	
	func testPlanetListItems() async throws {
		await viewModel.dispatch(.onAppear)

		XCTAssertEqual(viewModel.peopleListItems.count, 1)
	}
	
	func testPlanetListItemsShouldBeEmptyBeforeOnAppear() async throws {
		XCTAssertTrue(viewModel.peopleListItems.isEmpty)
		XCTAssertTrue(viewModel.model.results.isEmpty)
	}
	
	func testRefreshList() async throws {
		await viewModel.dispatch(.refresh)
		
		XCTAssertEqual(viewModel.peopleListItems.count, 1)
	}
	
	func testRefreshListDuplicate() async throws {
		await viewModel.dispatch(.refresh)
		await viewModel.dispatch(.refresh)

		XCTAssertEqual(viewModel.peopleListItems.count, 1)
	}

	func testSelectPlanet() async throws {
		await viewModel.dispatch(.onAppear)
		
		let personId = try XCTUnwrap(viewModel.model.results.first?.id)
		await viewModel.dispatch(.selectPerson(personId))
	}
	
	func testDidTapPillUnimplemented() async throws {
		await viewModel.dispatch(.didTapPill(1))
	}
	
	func testServiceError() async throws {
		viewModel = SWPeopleViewModel(service: SWService(fetchPlanets: {
			throw SWError.message("Server error")
		}, fetchFilms: {
			fatalError()
		}, fetchPeople: {
			throw SWError.message("Server error")
		}))
		
		await viewModel.dispatch(.onAppear)
		
		XCTAssertNotNil(viewModel.error)
		XCTAssertFalse(viewModel.isLoading)
	}
}
