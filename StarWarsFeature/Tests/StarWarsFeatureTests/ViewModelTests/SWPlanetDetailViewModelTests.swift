import XCTest
@testable import StarWarsFeature

@MainActor
final class SWPlanetDetailViewModelTests: XCTestCase {
	var viewModel: SWPlanetDetailViewModel!
	var mockPlanet: NewSWPlanet!
	
	override func setUp() async throws {
		mockPlanet = NewSWPlanet(
			properties: SWPlanet(
				name: "Tatooine",
				rotationPeriod: "23",
				orbitalPeriod: "304",
				diameter: "10465",
				climate: "arid",
				gravity: "1 standard",
				terrain: "desert",
				surfaceWater: "1",
				population: "200000",
				created: "2014-12-09T13:50:49.641000Z",
				edited: "2014-12-20T20:58:18.411000Z",
				url: "https://swapi.dev/api/planets/1/"
			),
			id: "1",
			description: "",
			uid: "1",
			v: 1
		)
		
		viewModel = SWPlanetDetailViewModel(planet: mockPlanet)
	}
	
	override func tearDown() async throws {
		viewModel = nil
		mockPlanet = nil
	}
	
	func testInitialization() {
		XCTAssertEqual(viewModel.planetName, "Tatooine")
		XCTAssertEqual(viewModel.climate, "arid")
		XCTAssertEqual(viewModel.population, "200000")
		XCTAssertEqual(viewModel.diameter, "10465")
		XCTAssertEqual(viewModel.gravity, "1 standard")
		XCTAssertEqual(viewModel.terrain, "desert")
	}
	
	func testInitializationWithDifferentPlanet() {
		// Given
		let differentPlanet = NewSWPlanet(
			properties: SWPlanet(
				name: "Alderaan",
				rotationPeriod: "24",
				orbitalPeriod: "364",
				diameter: "12500",
				climate: "temperate",
				gravity: "1 standard",
				terrain: "grasslands, mountains",
				surfaceWater: "40",
				population: "2000000000",
				created: "2014-12-10T11:35:48.479000Z",
				edited: "2014-12-20T20:58:18.420000Z",
				url: "https://swapi.dev/api/planets/2/"
			),
			id: "2",
			description: "",
			uid: "2",
			v: 1
		)
		
		// When
		let newViewModel = SWPlanetDetailViewModel(planet: differentPlanet)
		
		// Then
		XCTAssertEqual(newViewModel.planetName, "Alderaan")
		XCTAssertEqual(newViewModel.climate, "temperate")
		XCTAssertEqual(newViewModel.population, "2000000000")
		XCTAssertEqual(newViewModel.diameter, "12500")
		XCTAssertEqual(newViewModel.gravity, "1 standard")
		XCTAssertEqual(newViewModel.terrain, "grasslands, mountains")
	}
	
	func testPropertyMapping() {
		// Test that all properties are correctly mapped from the planet
		XCTAssertEqual(viewModel.planetName, mockPlanet.properties.name)
		XCTAssertEqual(viewModel.climate, mockPlanet.properties.climate)
		XCTAssertEqual(viewModel.population, mockPlanet.properties.population)
		XCTAssertEqual(viewModel.diameter, mockPlanet.properties.diameter)
		XCTAssertEqual(viewModel.gravity, mockPlanet.properties.gravity)
		XCTAssertEqual(viewModel.terrain, mockPlanet.properties.terrain)
	}
	
	func testInitializationWithDefaultPlanet() {
		// Given
		let defaultPlanet = NewSWPlanet.default
		
		// When
		let defaultViewModel = SWPlanetDetailViewModel(planet: defaultPlanet)
		
		// Then
		XCTAssertEqual(defaultViewModel.planetName, defaultPlanet.properties.name)
		XCTAssertEqual(defaultViewModel.climate, defaultPlanet.properties.climate)
		XCTAssertEqual(defaultViewModel.population, defaultPlanet.properties.population)
		XCTAssertEqual(defaultViewModel.diameter, defaultPlanet.properties.diameter)
		XCTAssertEqual(defaultViewModel.gravity, defaultPlanet.properties.gravity)
		XCTAssertEqual(defaultViewModel.terrain, defaultPlanet.properties.terrain)
	}
	
	func testInitializationWithEmptyStrings() {
		// Given
		let planetWithEmptyStrings = NewSWPlanet(
			properties: SWPlanet(
				name: "",
				rotationPeriod: "",
				orbitalPeriod: "",
				diameter: "",
				climate: "",
				gravity: "",
				terrain: "",
				surfaceWater: "",
				population: "",
				created: "",
				edited: "",
				url: ""
			),
			id: "",
			description: "",
			uid: "",
			v: 0
		)
		
		// When
		let emptyViewModel = SWPlanetDetailViewModel(planet: planetWithEmptyStrings)
		
		// Then
		XCTAssertEqual(emptyViewModel.planetName, "")
		XCTAssertEqual(emptyViewModel.climate, "")
		XCTAssertEqual(emptyViewModel.population, "")
		XCTAssertEqual(emptyViewModel.diameter, "")
		XCTAssertEqual(emptyViewModel.gravity, "")
		XCTAssertEqual(emptyViewModel.terrain, "")
	}
}
