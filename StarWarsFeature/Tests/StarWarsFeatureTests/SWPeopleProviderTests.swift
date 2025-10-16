import XCTest
import StarWarsFeature

final class SWPeopleProviderTests: XCTestCase {
	var peopleService: SWService!
	
	override func setUpWithError() throws {
		peopleService = SWService.test
	}
	
	override func tearDownWithError() throws {
		peopleService = nil
	}
	
	// MARK: - Success Path Tests
	
	func testFetchPeopleSuccess() async throws {
		let response = try await peopleService.fetchPeople()
		
		XCTAssertEqual(response.count, 82)
		XCTAssertEqual(response.results.count, 1)
		XCTAssertEqual(response.next, "https://swapi.dev/api/people/?page=2")
		XCTAssertNil(response.previous)
	}
	
	func testFetchPeopleDataStructure() async throws {
		let response = try await peopleService.fetchPeople()
		let person = response.results.first!
		
		// Test basic properties
		XCTAssertEqual(person.name, "Luke Skywalker")
		XCTAssertEqual(person.height, "172")
		XCTAssertEqual(person.mass, "77")
		XCTAssertEqual(person.hairColor, "blond")
		XCTAssertEqual(person.skinColor, "fair")
		XCTAssertEqual(person.eyeColor, "blue")
		XCTAssertEqual(person.birthYear, "19BBY")
		XCTAssertEqual(person.gender, "male")
		XCTAssertEqual(person.homeworld, "https://swapi.dev/api/planets/1/")
		XCTAssertEqual(person.url, "https://swapi.dev/api/people/1/")
	}
	
	func testFetchPeopleArrays() async throws {
		let response = try await peopleService.fetchPeople()
		let person = response.results.first!
		
		// Test film URLs
		XCTAssertEqual(person.films.count, 4)
		XCTAssertTrue(person.films.contains("https://swapi.dev/api/films/1/"))
		XCTAssertTrue(person.films.contains("https://swapi.dev/api/films/2/"))
		XCTAssertTrue(person.films.contains("https://swapi.dev/api/films/3/"))
		XCTAssertTrue(person.films.contains("https://swapi.dev/api/films/6/"))
		
		// Test species (empty in test data)
		XCTAssertTrue(person.species.isEmpty)
		
		// Test vehicles
		XCTAssertEqual(person.vehicles.count, 2)
		XCTAssertTrue(person.vehicles.contains("https://swapi.dev/api/vehicles/14/"))
		XCTAssertTrue(person.vehicles.contains("https://swapi.dev/api/vehicles/30/"))
		
		// Test starships
		XCTAssertEqual(person.starships.count, 2)
		XCTAssertTrue(person.starships.contains("https://swapi.dev/api/starships/12/"))
		XCTAssertTrue(person.starships.contains("https://swapi.dev/api/starships/22/"))
	}
	
	func testFetchPeopleTimestamps() async throws {
		let response = try await peopleService.fetchPeople()
		let person = response.results.first!
		
		XCTAssertEqual(person.created, "2014-12-09T13:50:51.644000Z")
		XCTAssertEqual(person.edited, "2014-12-20T21:17:56.891000Z")
	}
	
	func testFetchPeopleIdentifiable() async throws {
		let response = try await peopleService.fetchPeople()
		let person = response.results.first!
		
		// Test that SWPeople conforms to Identifiable
		XCTAssertFalse(person.id.isEmpty)
	}
	
	// MARK: - Error Path Tests
	
	func testFetchPeopleInvalidURL() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				throw SWError.invalidURL
			}
		)
		
		do {
			_ = try await peopleService.fetchPeople()
			XCTFail("Expected SWError.invalidURL to be thrown")
		} catch let error as SWError {
			XCTAssertEqual(error.localizedDescription, "Invalid URL")
		} catch {
			XCTFail("Expected SWError.invalidURL, got \(type(of: error))")
		}
	}
	
	func testFetchPeopleInvalidResponse() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				throw SWError.invalidResponse
			}
		)
		
		do {
			_ = try await peopleService.fetchPeople()
			XCTFail("Expected SWError.invalidResponse to be thrown")
		} catch let error as SWError {
			XCTAssertEqual(error.localizedDescription, "Invalid Response")
		} catch {
			XCTFail("Expected SWError.invalidResponse, got \(type(of: error))")
		}
	}
	
	func testFetchPeopleCustomMessage() async throws {
		let customMessage = "Network timeout occurred"
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				throw SWError.message(customMessage)
			}
		)
		
		do {
			_ = try await peopleService.fetchPeople()
			XCTFail("Expected SWError.message to be thrown")
		} catch let error as SWError {
			if case .message(let message) = error {
				XCTAssertEqual(message, customMessage)
				XCTAssertEqual(error.localizedDescription, customMessage)
			} else {
				XCTFail("Expected SWError.message, got \(error)")
			}
		} catch {
			XCTFail("Expected SWError.message, got \(type(of: error))")
		}
	}
	
	func testFetchPeopleNetworkError() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				throw URLError(.notConnectedToInternet)
			}
		)
		
		do {
			_ = try await peopleService.fetchPeople()
			XCTFail("Expected URLError to be thrown")
		} catch let error as URLError {
			XCTAssertEqual(error.code, .notConnectedToInternet)
		} catch {
			XCTFail("Expected URLError, got \(type(of: error))")
		}
	}
	
	func testFetchPeopleDecodingError() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				throw DecodingError.dataCorrupted(
					DecodingError.Context(
						codingPath: [],
						debugDescription: "Invalid JSON data"
					)
				)
			}
		)
		
		do {
			_ = try await peopleService.fetchPeople()
			XCTFail("Expected DecodingError to be thrown")
		} catch is DecodingError {
			// Expected error type
		} catch {
			XCTFail("Expected DecodingError, got \(type(of: error))")
		}
	}
	
	// MARK: - Edge Cases
	
	func testFetchPeopleEmptyResults() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				SWPeopleResponse(
					count: 0,
					next: "",
					previous: nil,
					results: []
				)
			}
		)
		
		let response = try await peopleService.fetchPeople()
		
		XCTAssertEqual(response.count, 0)
		XCTAssertTrue(response.results.isEmpty)
		XCTAssertEqual(response.next, "")
		XCTAssertNil(response.previous)
	}
	
	func testFetchPeopleMultiplePages() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				SWPeopleResponse(
					count: 100,
					next: "https://swapi.dev/api/people/?page=3",
					previous: "https://swapi.dev/api/people/?page=1",
					results: [
						SWPeople(
							name: "Person 1",
							height: "180",
							mass: "80",
							hairColor: "brown",
							skinColor: "light",
							eyeColor: "brown",
							birthYear: "20BBY",
							gender: "male",
							homeworld: "https://swapi.dev/api/planets/1/",
							films: [],
							species: [],
							vehicles: [],
							starships: [],
							created: "2014-12-09T13:50:51.644000Z",
							edited: "2014-12-20T21:17:56.891000Z",
							url: "https://swapi.dev/api/people/1/"
						),
						SWPeople(
							name: "Person 2",
							height: "160",
							mass: "60",
							hairColor: "black",
							skinColor: "dark",
							eyeColor: "brown",
							birthYear: "22BBY",
							gender: "female",
							homeworld: "https://swapi.dev/api/planets/2/",
							films: [],
							species: [],
							vehicles: [],
							starships: [],
							created: "2014-12-09T13:50:51.644000Z",
							edited: "2014-12-20T21:17:56.891000Z",
							url: "https://swapi.dev/api/people/2/"
						)
					]
				)
			}
		)
		
		let response = try await peopleService.fetchPeople()
		
		XCTAssertEqual(response.count, 100)
		XCTAssertEqual(response.results.count, 2)
		XCTAssertEqual(response.next, "https://swapi.dev/api/people/?page=3")
		XCTAssertEqual(response.previous, "https://swapi.dev/api/people/?page=1")
		XCTAssertEqual(response.results[0].name, "Person 1")
		XCTAssertEqual(response.results[1].name, "Person 2")
	}
	
	// MARK: - Concurrency Tests
	
	func testFetchPeopleConcurrentCalls() async throws {
		// Test that multiple concurrent calls work correctly
		async let response1 = peopleService.fetchPeople()
		async let response2 = peopleService.fetchPeople()
		async let response3 = peopleService.fetchPeople()
		
		let (result1, result2, result3) = try await (response1, response2, response3)
		
		XCTAssertEqual(result1.count, result2.count)
		XCTAssertEqual(result2.count, result3.count)
		XCTAssertEqual(result1.results.count, result2.results.count)
		XCTAssertEqual(result2.results.count, result3.results.count)
	}
	
	func testFetchPeopleCancellation() async throws {
		peopleService = SWService(
			fetchPlanets: { fatalError() },
			fetchFilms: { fatalError() },
			fetchPeople: {
				try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
				return SWPeopleResponse.noop
			}
		)
		
		let task = Task {
			try await peopleService.fetchPeople()
		}
		
		// Cancel the task immediately
		task.cancel()
		
		do {
			_ = try await task.value
			XCTFail("Expected task to be cancelled")
		} catch is CancellationError {
			// Expected cancellation
		} catch {
			XCTFail("Expected CancellationError, got \(type(of: error))")
		}
	}
}
