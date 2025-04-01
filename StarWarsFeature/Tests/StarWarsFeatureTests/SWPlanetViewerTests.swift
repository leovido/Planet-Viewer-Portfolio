import XCTest
@testable import StarWarsFeature

final class SWPlanetViewerTests: XCTestCase {
	var planetsService: SWPlanetsProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.test
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testExample() async throws {
		let planets = try await planetsService.fetchPlanets()
		
		XCTAssertEqual(planets.count, 1)
		XCTAssertEqual(planets.planets.first!.name, "Tatooine")
	}
}
