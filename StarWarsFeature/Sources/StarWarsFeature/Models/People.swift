import Foundation

public struct SWPeopleResponse: Codable, Hashable, Sendable {
	public let message: String?
	public let totalRecords: Int
	public let totalPages: Int?
	public let next: String?
	public let previous: String?
	public let apiVersion: String?
	public let timestamp: String?
	public let results: [NewSWPeople]
	
	public init(
		message: String?,
		totalRecords: Int,
		totalPages: Int?,
		next: String?,
		previous: String?,
		apiVersion: String?,
		timestamp: String?,
		results: [NewSWPeople]
	) {
		self.message = message
		self.totalRecords = totalRecords
		self.totalPages = totalPages
		self.next = next
		self.previous = previous
		self.apiVersion = apiVersion
		self.timestamp = timestamp
		self.results = results
	}
	
	enum CodingKeys: String, CodingKey {
		case message
		case totalRecords = "total_records"
		case totalPages = "total_pages"
		case next, previous
		case apiVersion
		case timestamp
		case results
	}
}

public struct SWPeopleResult: Codable, Hashable, Sendable {
	public let uid: String
	public let name: String = ""
	public let url: String = ""
	
	enum CodingKeys: String, CodingKey {
		case uid
		case name
		case url
	}
}

public struct NewSWPeople: Codable, Hashable, Sendable {
	public let properties: SWPeople
	public let id: String
	public let description: String
	public let uid: String
	public let v: Int
	
	public init(properties: SWPeople, id: String, description: String, uid: String, v: Int) {
		self.properties = properties
		self.id = id
		self.description = description
		self.uid = uid
		self.v = v
	}
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case properties
		case description, uid
		case v = "__v"
	}
}

public struct SWPeople: Hashable, Codable, Sendable {
	public let name, height, mass, hairColor: String
	public let skinColor, eyeColor, birthYear, gender: String
	public let homeworld: String
	public let films: [String]
	public let vehicles, starships: [String]
	public let created, edited: String
	public let url: String
	
	public init(
		name: String,
		height: String,
		mass: String,
		hairColor: String,
		skinColor: String,
		eyeColor: String,
		birthYear: String,
		gender: String,
		homeworld: String,
		films: [String],
		vehicles: [String],
		starships: [String],
		created: String,
		edited: String,
		url: String
	) {
		self.name = name
		self.height = height
		self.mass = mass
		self.hairColor = hairColor
		self.skinColor = skinColor
		self.eyeColor = eyeColor
		self.birthYear = birthYear
		self.gender = gender
		self.homeworld = homeworld
		self.films = films
		self.vehicles = vehicles
		self.starships = starships
		self.created = created
		self.edited = edited
		self.url = url
	}
	
	enum CodingKeys: String, CodingKey {
		case name, height, mass
		case hairColor = "hair_color"
		case skinColor = "skin_color"
		case eyeColor = "eye_color"
		case birthYear = "birth_year"
		case gender, homeworld, films
		case vehicles, starships
		case created, edited, url
	}
}

extension SWPeople {
	public static let `default`: SWPeople = .init(
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
			"https://swapi.dev/api/films/3/",
			"https://swapi.dev/api/films/6/"
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
}

extension SWPeopleResponse {
	public static let noop: SWPeopleResponse = .init(
		message: nil,
		totalRecords: 0,
		totalPages: nil,
		next: nil,
		previous: nil,
		apiVersion: nil,
		timestamp: nil,
		results: [])
}
