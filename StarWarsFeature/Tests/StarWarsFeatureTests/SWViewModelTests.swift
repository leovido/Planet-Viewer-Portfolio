import XCTest
@testable import StarWarsFeature

@MainActor
final class SWViewModelTests: XCTestCase {
	var viewModel: SWPlanetViewModel!
	
	override func setUp() async throws {
		viewModel = .init(service: SWService.test)
	}
	
	override func tearDown() async throws {
		viewModel = nil
	}
	
	func testOnAppear() async throws {
		XCTAssertEqual(viewModel.model.count, 0)
		XCTAssertEqual(viewModel.isLoading, false)
		await viewModel.dispatch(.onAppear)
		XCTAssertEqual(viewModel.model.count, 7)
	}
	
	func testPlanetListItems() async throws {
		await viewModel.dispatch(.onAppear)

		XCTAssertEqual(viewModel.planetListItems.count, 6)
	}
	
	func testPlanetListItemsShouldBeEmptyBeforeOnAppear() async throws {
		XCTAssertTrue(viewModel.planetListItems.isEmpty)
		XCTAssertTrue(viewModel.model.planets.isEmpty)
	}
	
	func testRefreshList() async throws {
		await viewModel.dispatch(.refresh)
		
		XCTAssertEqual(viewModel.planetListItems.count, 6)
	}
	
	func testRefreshListDuplicate() async throws {
		await viewModel.dispatch(.refresh)
		await viewModel.dispatch(.refresh)

		XCTAssertEqual(viewModel.planetListItems.count, 6)
	}

	func testSelectPlanet() async throws {
		await viewModel.dispatch(.onAppear)
		
		let planetId = viewModel.model.planets.first!.id
		await viewModel.dispatch(.selectPlanet(planetId))
	}
	
	func testDidTapPillUnimplemented() async throws {
		await viewModel.dispatch(.didTapPill(1))
	}
	
	func testServiceError() async throws {
		viewModel = SWPlanetViewModel(service: SWService(fetchPlanets: {
			throw SWError.message("Server error")
		}, fetchPeople: {
			fatalError()
		}))
		
		await viewModel.dispatch(.onAppear)
		
		XCTAssertNotNil(viewModel.error)
		XCTAssertFalse(viewModel.isLoading)
	}
}
