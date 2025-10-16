import XCTest
@testable import StarWarsFeature

final class SWPlanetsProviderTests: XCTestCase {
	var planetsService: SWAPIProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.test
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testFetchPlanets() async throws {
		let response = try await planetsService.fetchPlanets()
		
		XCTAssertEqual(response.planets.count, 2)
		XCTAssertEqual(response.planets.first!.properties.name, "Alderaan")
	}
	
	func testFetchPlanetsError() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.invalidResponse
		}, fetchFilms: {
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
		}, fetchFilms: {
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
		}, fetchFilms: {
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
