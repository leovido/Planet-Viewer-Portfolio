import XCTest
@testable import StarWarsFeature

final class ModelInitializerTests: XCTestCase {
	
	// MARK: - PersonDetailModel Initializer Tests
	
	func testPersonDetailModelInitializer() {
		// Given
		let person = SWPeople(
			name: "Luke Skywalker",
			height: "172",
			mass: "77",
			hairColor: "blond",
			skinColor: "fair",
			eyeColor: "blue",
			birthYear: "19BBY",
			gender: "male",
			homeworld: "https://swapi.dev/api/planets/1/",
			films: [
				"https://swapi.dev/api/films/1/",
				"https://swapi.dev/api/films/2/",
				"https://swapi.dev/api/films/3/"
			],
			vehicles: [
				"https://swapi.dev/api/vehicles/14/",
				"https://swapi.dev/api/vehicles/30/"
			],
			starships: [
				"https://swapi.dev/api/starships/12/",
				"https://swapi.dev/api/starships/22/"
			],
			created: "2014-12-09T13:50:51.644000Z",
			edited: "2014-12-20T21:17:56.891000Z",
			url: "https://swapi.dev/api/people/1/"
		)
		
		// When
		let personDetailModel = PersonDetailModel(from: person)
		
		// Then
		XCTAssertEqual(personDetailModel.name, "Luke Skywalker")
		XCTAssertEqual(personDetailModel.hometown, "https://swapi.dev/api/planets/1/")
		XCTAssertEqual(personDetailModel.films.count, 3)
		XCTAssertEqual(personDetailModel.vehicles.count, 2)
		XCTAssertEqual(personDetailModel.starships.count, 2)
		XCTAssertFalse(personDetailModel.id.isEmpty)
	}
	
	func testPersonDetailModelInitializerWithEmptyArrays() {
		// Given
		let person = SWPeople(
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
			created: "2014-12-10T15:18:20.704000Z",
			edited: "2014-12-20T21:17:50.313000Z",
			url: "https://swapi.dev/api/people/4/"
		)
		
		// When
		let personDetailModel = PersonDetailModel(from: person)
		
		// Then
		XCTAssertEqual(personDetailModel.name, "Darth Vader")
		XCTAssertEqual(personDetailModel.hometown, "https://swapi.dev/api/planets/1/")
		XCTAssertEqual(personDetailModel.films.count, 0)
		XCTAssertEqual(personDetailModel.vehicles.count, 0)
		XCTAssertEqual(personDetailModel.starships.count, 0)
		XCTAssertFalse(personDetailModel.id.isEmpty)
	}
	
	func testPersonDetailModelGeneratesUniqueIds() {
		// Given
		let person1 = SWPeople.default
		let person2 = SWPeople.default
		
		// When
		let model1 = PersonDetailModel(from: person1)
		let model2 = PersonDetailModel(from: person2)
		
		// Then
		XCTAssertNotEqual(model1.id, model2.id)
	}
	
	// MARK: - PlanetListItem Initializer Tests
	
	func testPlanetListItemFromSWPlanet() {
		// Given
		let planet = SWPlanet(
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
		)
		
		// When
		let planetListItem = PlanetListItem(from: planet)
		
		// Then
		XCTAssertEqual(planetListItem.name, "Tatooine")
		XCTAssertEqual(planetListItem.climate, "arid")
		XCTAssertEqual(planetListItem.population, "200000")
		XCTAssertEqual(planetListItem.id, planet.id)
	}
	
	func testPlanetListItemFromNewSWPlanet() {
		// Given
		let newPlanet = NewSWPlanet(
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
		let planetListItem = PlanetListItem(from: newPlanet)
		
		// Then
		XCTAssertEqual(planetListItem.name, "Alderaan")
		XCTAssertEqual(planetListItem.climate, "temperate")
		XCTAssertEqual(planetListItem.population, "2000000000")
		XCTAssertEqual(planetListItem.id, "2")
	}
	
	func testPlanetListItemFromDefaultPlanet() {
		// Given
		let defaultPlanet = SWPlanet.default
		
		// When
		let planetListItem = PlanetListItem(from: defaultPlanet)
		
		// Then
		XCTAssertEqual(planetListItem.name, "Naboo")
		XCTAssertEqual(planetListItem.climate, "temperate")
		XCTAssertEqual(planetListItem.population, "4500000000")
		XCTAssertEqual(planetListItem.id, defaultPlanet.id)
	}
	
	// MARK: - FilmListItem Initializer Tests
	
	func testFilmListItemInitializer() {
		// Given
		let film = NewSWFilm(
			properties: SWFilm(
				title: "Star Wars: Episode IV - A New Hope",
				director: "George Lucas",
				releaseDate: "1977-05-25"
			),
			id: "1",
			description: "",
			uid: "1",
			v: 1
		)
		
		// When
		let filmListItem = FilmListItem(from: film)
		
		// Then
		XCTAssertEqual(filmListItem.title, "Star Wars: Episode IV - A New Hope")
		XCTAssertEqual(filmListItem.director, "George Lucas")
		XCTAssertEqual(filmListItem.releaseDate, "1977-05-25")
		XCTAssertFalse(filmListItem.id.isEmpty)
	}
	
	func testFilmListItemInitializerWithDifferentData() {
		// Given
		let film = NewSWFilm(
			properties: SWFilm(
				title: "Star Wars: Episode V - The Empire Strikes Back",
				director: "Irvin Kershner",
				releaseDate: "1980-05-17"
			),
			id: "2",
			description: "",
			uid: "2",
			v: 1
		)
		
		// When
		let filmListItem = FilmListItem(from: film)
		
		// Then
		XCTAssertEqual(filmListItem.title, "Star Wars: Episode V - The Empire Strikes Back")
		XCTAssertEqual(filmListItem.director, "Irvin Kershner")
		XCTAssertEqual(filmListItem.releaseDate, "1980-05-17")
		XCTAssertFalse(filmListItem.id.isEmpty)
	}
	
	func testFilmListItemInitializerWithEmptyStrings() {
		// Given
		let film = NewSWFilm(
			properties: SWFilm(
				title: "",
				director: "",
				releaseDate: ""
			),
			id: "",
			description: "",
			uid: "",
			v: 0
		)
		
		// When
		let filmListItem = FilmListItem(from: film)
		
		// Then
		XCTAssertEqual(filmListItem.title, "")
		XCTAssertEqual(filmListItem.director, "")
		XCTAssertEqual(filmListItem.releaseDate, "")
		XCTAssertFalse(filmListItem.id.isEmpty)
	}
	
	func testFilmListItemGeneratesUniqueIds() {
		// Given
		let film1 = NewSWFilm(
			properties: .default,
			id: "1",
			description: "",
			uid: "1",
			v: 1
		)
		let film2 = NewSWFilm(
			properties: .default,
			id: "2",
			description: "",
			uid: "2",
			v: 1
		)
		
		// When
		let listItem1 = FilmListItem(from: film1)
		let listItem2 = FilmListItem(from: film2)
		
		// Then
		XCTAssertNotEqual(listItem1.id, listItem2.id)
	}
	
	// MARK: - PersonListItem Initializer Tests
	
	func testPersonListItemInitializer() {
		// Given
		let person = SWPeople(
			name: "Luke Skywalker",
			height: "172",
			mass: "77",
			hairColor: "blond",
			skinColor: "fair",
			eyeColor: "blue",
			birthYear: "19BBY",
			gender: "male",
			homeworld: "https://swapi.dev/api/planets/1/",
			films: [
				"https://swapi.dev/api/films/1/",
				"https://swapi.dev/api/films/2/",
				"https://swapi.dev/api/films/3/"
			],
			vehicles: [],
			starships: [],
			created: "2014-12-09T13:50:51.644000Z",
			edited: "2014-12-20T21:17:56.891000Z",
			url: "https://swapi.dev/api/people/1/"
		)
		
		// When
		let personListItem = PersonListItem(from: person)
		
		// Then
		XCTAssertEqual(personListItem.name, "Luke Skywalker")
		XCTAssertEqual(personListItem.numberOfFilms, 3)
		XCTAssertEqual(personListItem.hairColor, "blond")
		XCTAssertFalse(personListItem.id.isEmpty)
	}
	
	func testPersonListItemInitializerWithNoFilms() {
		// Given
		let person = SWPeople(
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
			created: "2014-12-10T15:18:20.704000Z",
			edited: "2014-12-20T21:17:50.313000Z",
			url: "https://swapi.dev/api/people/4/"
		)
		
		// When
		let personListItem = PersonListItem(from: person)
		
		// Then
		XCTAssertEqual(personListItem.name, "Darth Vader")
		XCTAssertEqual(personListItem.numberOfFilms, 0)
		XCTAssertEqual(personListItem.hairColor, "none")
		XCTAssertFalse(personListItem.id.isEmpty)
	}
	
	func testPersonListItemInitializerWithManyFilms() {
		// Given
		let person = SWPeople(
			name: "Leia Organa",
			height: "150",
			mass: "49",
			hairColor: "brown",
			skinColor: "light",
			eyeColor: "brown",
			birthYear: "19BBY",
			gender: "female",
			homeworld: "https://swapi.dev/api/planets/2/",
			films: [
				"https://swapi.dev/api/films/1/",
				"https://swapi.dev/api/films/2/",
				"https://swapi.dev/api/films/3/",
				"https://swapi.dev/api/films/6/",
				"https://swapi.dev/api/films/7/"
			],
			vehicles: [],
			starships: [],
			created: "2014-12-10T15:20:09.791000Z",
			edited: "2014-12-20T21:17:50.315000Z",
			url: "https://swapi.dev/api/people/5/"
		)
		
		// When
		let personListItem = PersonListItem(from: person)
		
		// Then
		XCTAssertEqual(personListItem.name, "Leia Organa")
		XCTAssertEqual(personListItem.numberOfFilms, 5)
		XCTAssertEqual(personListItem.hairColor, "brown")
		XCTAssertFalse(personListItem.id.isEmpty)
	}
	
	func testPersonListItemGeneratesUniqueIds() {
		// Given
		let person1 = SWPeople.default
		let person2 = SWPeople.default
		
		// When
		let listItem1 = PersonListItem(from: person1)
		let listItem2 = PersonListItem(from: person2)
		
		// Then
		XCTAssertNotEqual(listItem1.id, listItem2.id)
	}
}
