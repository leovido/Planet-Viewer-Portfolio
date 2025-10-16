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
	let description: String
	public let uid: String
	let v: Int
	
	enum CodingKeys: String, CodingKey {
		case properties
		case id = "_id"
		case description, uid
		case v = "__v"
	}
}

public struct SWPeople: Identifiable, Hashable, Codable, Sendable {
	public let id: String
	public let name, height, mass, hairColor: String
	public let skinColor, eyeColor, birthYear, gender: String
	public let homeworld: String
	public let films: [String]
	public let vehicles, starships: [String]
	public let created, edited: String
	public let url: String
	
	public init(
		id: String = UUID().uuidString,
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
		self.id = id
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
		case species, vehicles, starships
		case created, edited, url
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = UUID().uuidString
		self.name = try container.decode(String.self, forKey: .name)
		self.height = try container.decode(String.self, forKey: .height)
		self.mass = try container.decode(String.self, forKey: .mass)
		self.hairColor = try container.decode(String.self, forKey: .hairColor)
		self.skinColor = try container.decode(String.self, forKey: .skinColor)
		self.eyeColor = try container.decode(String.self, forKey: .eyeColor)
		self.birthYear = try container.decode(String.self, forKey: .birthYear)
		self.gender = try container.decode(String.self, forKey: .gender)
		self.homeworld = try container.decode(String.self, forKey: .homeworld)
		self.films = try container.decode([String].self, forKey: .films)
		self.vehicles = try container.decode([String].self, forKey: .vehicles)
		self.starships = try container.decode([String].self, forKey: .starships)
		self.created = try container.decode(String.self, forKey: .created)
		self.edited = try container.decode(String.self, forKey: .edited)
		self.url = try container.decode(String.self, forKey: .url)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(height, forKey: .height)
		try container.encode(mass, forKey: .mass)
		try container.encode(hairColor, forKey: .hairColor)
		try container.encode(skinColor, forKey: .skinColor)
		try container.encode(eyeColor, forKey: .eyeColor)
		try container.encode(birthYear, forKey: .birthYear)
		try container.encode(gender, forKey: .gender)
		try container.encode(homeworld, forKey: .homeworld)
		try container.encode(films, forKey: .films)
		try container.encode(vehicles, forKey: .vehicles)
		try container.encode(starships, forKey: .starships)
		try container.encode(created, forKey: .created)
		try container.encode(edited, forKey: .edited)
		try container.encode(url, forKey: .url)
	}
}

extension SWPeople {
	static let `default`: SWPeople = .init(
		id: "1",
		name: "https://swapi.dev/api/planets/1/",
		height: "172",
		mass: "4323",
		hairColor: "blonde",
		skinColor: "green",
		eyeColor: "Luke Skywalker",
		birthYear: "19BBY",
		gender: "blue",
		homeworld: "male",
		films: [],
		vehicles: [],
		starships: [],
		created: "",
		edited: "",
		url: ""
	)
}

public struct PersonListItem: Identifiable {
	public let id: String
	public let name: String
	public let numberOfFilms: Int
	public let hairColor: String

	public init(from person: SWPeople) {
		self.id = person.id
		self.name = person.name
		self.numberOfFilms = person.films.count
		self.hairColor = person.hairColor
	}
}

extension PersonListItem: CardDisplayable {
	typealias Model = Self
	
	var title: String {
		return name
	}
	
	var description: String {
		return "# of films: \(numberOfFilms.description)"
	}
	
	var caption: String {
		return hairColor
	}
}

public struct PersonDetailModel: Identifiable {
	public let id: String
	public let name: String
	public let hometown: String
	public let films: [String]
	public let vehicles: [String]
	public let starships: [String]
	
	public init(from person: SWPeople) {
		self.id = person.id
		self.name = person.name
		self.hometown = person.homeworld
		self.films = person.films
		self.vehicles = person.vehicles
		self.starships = person.starships
	}
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
