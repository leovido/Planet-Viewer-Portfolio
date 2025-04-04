import XCTest
@testable import StarWarsFeature

final class SWPlanetsProviderTests: XCTestCase {
	var planetsService: SWPlanetsProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.test
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testFetchPlanets() async throws {
		let planets = try await planetsService.fetchPlanets()
		
		XCTAssertEqual(planets.count, 1)
		XCTAssertEqual(planets.planets.first!.name, "Tatooine")
	}
	
	func testFetchPlanetsError() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.invalidResponse
		}, fetchPeople: {
			throw SWError.invalidResponse
		})
		
		do {
			_ = try await planetsService.fetchPlanets()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Invalid Response")
		}
	}
	
	func testFetchPlanetsErrorInvalidURL() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.invalidURL
		}, fetchPeople: {
			throw SWError.invalidURL
		})
		
		do {
			_ = try await planetsService.fetchPlanets()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Invalid URL")
		}
	}
	
	func testFetchPlanetsCustomError() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.message("Custom message from backend")
		}, fetchPeople: {
			throw SWError.message("Custom message from backend")
		})
		
		do {
			_ = try await planetsService.fetchPlanets()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Custom message from backend")
		}
	}
}
