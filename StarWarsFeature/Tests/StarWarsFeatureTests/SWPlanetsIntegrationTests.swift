import XCTest
import StarWarsFeature

final class SWPlanetsProviderIntegrationTests: XCTestCase {
	var planetsService: SWPlanetsProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.live
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testFetchPlanetsFromLiveAPI() async throws {
		try XCTSkipIf(ProcessInfo.processInfo.environment["SKIP_INTEGRATION_TESTS"] == "YES",
					 "Skipping integration tests")
		
		let planets = try await planetsService.fetchPlanets()
		
		XCTAssertFalse(planets.planets.isEmpty, "Should return at least one planet")
		
		if let tatooine = planets.planets.first(where: { $0.properties.name == "Tatooine" }) {
			XCTAssertEqual(tatooine.properties.climate, "arid")
		}
	}
}
