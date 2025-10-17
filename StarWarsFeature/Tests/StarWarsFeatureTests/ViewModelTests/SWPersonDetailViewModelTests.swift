import XCTest
@testable import StarWarsFeature

@MainActor
final class SWPersonDetailViewModelTests: XCTestCase {
	var viewModel: SWPersonDetailViewModel!
	
	override func setUp() async throws {
		viewModel = SWPersonDetailViewModel()
	}
	
	override func tearDown() async throws {
		viewModel = nil
	}
	
	func testInitialState() {
		XCTAssertNil(viewModel.person)
		XCTAssertEqual(viewModel.name, "")
		XCTAssertEqual(viewModel.height, "")
		XCTAssertEqual(viewModel.mass, "")
		XCTAssertEqual(viewModel.hairColor, "")
		XCTAssertEqual(viewModel.skinColor, "")
		XCTAssertEqual(viewModel.gender, "")
	}
	
	func testUpdateDetailState() {
		// Given
		let mockPerson = SWPeople(
			name: "Luke Skywalker",
			height: "172",
			mass: "77",
			hairColor: "blond",
			skinColor: "fair",
			eyeColor: "blue",
			birthYear: "19BBY",
			gender: "male",
			homeworld: "https://swapi.dev/api/planets/1/",
			films: ["https://swapi.dev/api/films/1/"],
			vehicles: [],
			starships: [],
			created: "2014-12-09T13:50:51.644000Z",
			edited: "2014-12-20T21:17:56.891000Z",
			url: "https://swapi.dev/api/people/1/"
		)
		
		// When
		viewModel.updateDetailState(with: mockPerson)
		
		// Then
		XCTAssertEqual(viewModel.name, "Luke Skywalker")
		XCTAssertEqual(viewModel.height, "172")
		XCTAssertEqual(viewModel.mass, "77")
		XCTAssertEqual(viewModel.hairColor, "blond")
		XCTAssertEqual(viewModel.skinColor, "fair")
		XCTAssertEqual(viewModel.gender, "male")
	}
	
	func testUpdateDetailStateWithDifferentPerson() {
		// Given
		let mockPerson = SWPeople(
			name: "Leia Organa",
			height: "150",
			mass: "49",
			hairColor: "brown",
			skinColor: "light",
			eyeColor: "brown",
			birthYear: "19BBY",
			gender: "female",
			homeworld: "https://swapi.dev/api/planets/2/",
			films: ["https://swapi.dev/api/films/1/"],
			vehicles: [],
			starships: [],
			created: "2014-12-10T15:20:09.791000Z",
			edited: "2014-12-20T21:17:50.315000Z",
			url: "https://swapi.dev/api/people/5/"
		)
		
		// When
		viewModel.updateDetailState(with: mockPerson)
		
		// Then
		XCTAssertEqual(viewModel.name, "Leia Organa")
		XCTAssertEqual(viewModel.height, "150")
		XCTAssertEqual(viewModel.mass, "49")
		XCTAssertEqual(viewModel.hairColor, "brown")
		XCTAssertEqual(viewModel.skinColor, "light")
		XCTAssertEqual(viewModel.gender, "female")
	}
	
	func testUpdateDetailStateOverwritesPreviousValues() {
		// Given
		let firstPerson = SWPeople(
			name: "Luke Skywalker",
			height: "172",
			mass: "77",
			hairColor: "blond",
			skinColor: "fair",
			eyeColor: "blue",
			birthYear: "19BBY",
			gender: "male",
			homeworld: "https://swapi.dev/api/planets/1/",
			films: [],
			vehicles: [],
			starships: [],
			created: "",
			edited: "",
			url: ""
		)
		
		let secondPerson = SWPeople(
			name: "Darth Vader",
			height: "202",
			mass: "136",
			hairColor: "none",
			skinColor: "white",
			eyeColor: "yellow",
			birthYear: "41.9BBY",
			gender: "male",
			homeworld: "https://swapi.dev/api/planets/1/",
			films: [],
			vehicles: [],
			starships: [],
			created: "",
			edited: "",
			url: ""
		)
		
		// When
		viewModel.updateDetailState(with: firstPerson)
		viewModel.updateDetailState(with: secondPerson)
		
		// Then
		XCTAssertEqual(viewModel.name, "Darth Vader")
		XCTAssertEqual(viewModel.height, "202")
		XCTAssertEqual(viewModel.mass, "136")
		XCTAssertEqual(viewModel.hairColor, "none")
		XCTAssertEqual(viewModel.skinColor, "white")
		XCTAssertEqual(viewModel.gender, "male")
	}
}
