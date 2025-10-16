import XCTest
@testable import StarWarsFeature

final class SWFilmProviderTests: XCTestCase {
	var planetsService: SWAPIProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.test
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testFetchFilms() async throws {
		let response = try await planetsService.fetchFilms()
		
		XCTAssertEqual(response.results.count, 1)
		XCTAssertEqual(response.results.first!.title, "A New Hope")
	}
	
	func testFetchFilmsError() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.invalidResponse
		}, fetchFilms: {
			throw SWError.invalidResponse
		}, fetchPeople: {
			throw SWError.invalidResponse
		})
		
		do {
			_ = try await planetsService.fetchFilms()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Invalid Response")
		}
	}
	
	func testFetchFilmsErrorInvalidURL() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.invalidURL
		}, fetchFilms: {
			throw SWError.invalidURL
		}, fetchPeople: {
			throw SWError.invalidURL
		})
		
		do {
			_ = try await planetsService.fetchFilms()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Invalid URL")
		}
	}
	
	func testFetchFilmsCustomError() async throws {
		planetsService = SWService(fetchPlanets: {
			throw SWError.message("Custom message from backend")
		}, fetchFilms: {
			throw SWError.message("Custom message from backend")
		}, fetchPeople: {
			throw SWError.message("Custom message from backend")
		})
		
		do {
			_ = try await planetsService.fetchFilms()
			XCTFail("Expected error")
		} catch {
			XCTAssertTrue(error is SWError)
			XCTAssertEqual(error.localizedDescription, "Custom message from backend")
		}
	}
}
