import XCTest
@testable import StarWarsFeature

final class ModelExtensionsTests: XCTestCase {
	
	// MARK: - PlanetListItem+CardDisplayable Tests
	
	func testPlanetListItemCardDisplayable() {
		// Given
		let planet = NewSWPlanet(
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
		
		let planetListItem = PlanetListItem(from: planet)
		
		// When & Then
		XCTAssertEqual(planetListItem.title, "Tatooine")
		XCTAssertEqual(planetListItem.description, "arid")
		XCTAssertEqual(planetListItem.caption, "200000")
	}
	
	func testPlanetListItemCardDisplayableWithDifferentData() {
		// Given
		let planet = NewSWPlanet(
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
		
		let planetListItem = PlanetListItem(from: planet)
		
		// When & Then
		XCTAssertEqual(planetListItem.title, "Alderaan")
		XCTAssertEqual(planetListItem.description, "temperate")
		XCTAssertEqual(planetListItem.caption, "2000000000")
	}
	
	func testPlanetListItemCardDisplayableWithEmptyStrings() {
		// Given
		let planet = NewSWPlanet(
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
		
		let planetListItem = PlanetListItem(from: planet)
		
		// When & Then
		XCTAssertEqual(planetListItem.title, "")
		XCTAssertEqual(planetListItem.description, "")
		XCTAssertEqual(planetListItem.caption, "")
	}
	
	// MARK: - PersonListItem+CardDisplayable Tests
	
	func testPersonListItemCardDisplayable() {
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
		
		let personListItem = PersonListItem(from: person)
		
		// When & Then
		XCTAssertEqual(personListItem.title, "Luke Skywalker")
		XCTAssertEqual(personListItem.description, "# of films: 3")
		XCTAssertEqual(personListItem.caption, "blond")
	}
	
	func testPersonListItemCardDisplayableWithNoFilms() {
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
		
		let personListItem = PersonListItem(from: person)
		
		// When & Then
		XCTAssertEqual(personListItem.title, "Darth Vader")
		XCTAssertEqual(personListItem.description, "# of films: 0")
		XCTAssertEqual(personListItem.caption, "none")
	}
	
	func testPersonListItemCardDisplayableWithManyFilms() {
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
		
		let personListItem = PersonListItem(from: person)
		
		// When & Then
		XCTAssertEqual(personListItem.title, "Leia Organa")
		XCTAssertEqual(personListItem.description, "# of films: 5")
		XCTAssertEqual(personListItem.caption, "brown")
	}
	
	// MARK: - FilmListItem+CardDisplayable Tests
	
	func testFilmListItemCardDisplayable() {
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
		
		let filmListItem = FilmListItem(from: film)
		
		// When & Then
		XCTAssertEqual(filmListItem.description, "George Lucas")
		XCTAssertEqual(filmListItem.caption, "1977-05-25")
	}
	
	func testFilmListItemCardDisplayableWithDifferentData() {
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
		
		let filmListItem = FilmListItem(from: film)
		
		// When & Then
		XCTAssertEqual(filmListItem.description, "Irvin Kershner")
		XCTAssertEqual(filmListItem.caption, "1980-05-17")
	}
	
	func testFilmListItemCardDisplayableWithEmptyStrings() {
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
		
		let filmListItem = FilmListItem(from: film)
		
		// When & Then
		XCTAssertEqual(filmListItem.description, "")
		XCTAssertEqual(filmListItem.caption, "")
	}
	
	// MARK: - CardDisplayable Protocol Conformance Tests
	
	func testPlanetListItemConformsToCardDisplayable() {
		// Given
		let planet = NewSWPlanet.default
		let planetListItem = PlanetListItem(from: planet)
		
		// When & Then
		XCTAssertNotNil(planetListItem.title)
		XCTAssertNotNil(planetListItem.description)
		XCTAssertNotNil(planetListItem.caption)
	}
	
	func testPersonListItemConformsToCardDisplayable() {
		// Given
		let person = SWPeople.default
		let personListItem = PersonListItem(from: person)
		
		// When & Then
		XCTAssertNotNil(personListItem.title)
		XCTAssertNotNil(personListItem.description)
		XCTAssertNotNil(personListItem.caption)
	}
	
	func testFilmListItemConformsToCardDisplayable() {
		// Given
		let film = NewSWFilm(
			properties: .default,
			id: "1",
			description: "",
			uid: "1",
			v: 1
		)
		let filmListItem = FilmListItem(from: film)
		
		// When & Then
		XCTAssertNotNil(filmListItem.description)
		XCTAssertNotNil(filmListItem.caption)
	}
}
