import XCTest
@testable import StarWarsFeature

@MainActor
final class SWFilmViewModelTests: XCTestCase {
	var viewModel: SWFilmViewModel!
	
	override func setUp() async throws {
		viewModel = .init(service: SWService.test)
	}
	
	override func tearDown() async throws {
		viewModel = nil
	}
	
	func testOnAppear() async throws {
		XCTAssertEqual(viewModel.filmListItems.count, 0)
		XCTAssertEqual(viewModel.isLoading, false)
		await viewModel.dispatch(.onAppear)
	}
	
	func testFilmListItems() async throws {
		await viewModel.dispatch(.onAppear)

		XCTAssertEqual(viewModel.filmListItems.count, 1)
	}
	
	func testFilmListItemsShouldBeEmptyBeforeOnAppear() async throws {
		XCTAssertTrue(viewModel.filmListItems.isEmpty)
	}

	func testServiceError() async throws {
		viewModel = SWFilmViewModel(service: SWService(fetchPlanets: {
			throw SWError.message("Server error")
		}, fetchFilms: {
			throw SWError.message("Server error")
		}, fetchPeople: {
			throw SWError.message("Server error")
		}))
		
		await viewModel.dispatch(.onAppear)
		
		XCTAssertNotNil(viewModel.error)
		XCTAssertFalse(viewModel.isLoading)
	}
}
