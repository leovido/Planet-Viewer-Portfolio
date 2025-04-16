import Foundation

public struct SWPeopleResponse: Codable, Sendable {
	public let count: Int
	public let next: String
	public let previous: String?
	public let results: [SWPeople]
}

public struct SWPeople: Identifiable, Codable, Sendable {
	public let id: String = UUID().uuidString
	public let name, height, mass, hairColor: String
	public let skinColor, eyeColor, birthYear, gender: String
	public let homeworld: String
	public let films: [String]
	public let species: [String]
	public let vehicles, starships: [String]
	public let created, edited: String
	public let url: String
	
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
}

public struct PersonListItem: Identifiable {
	public let id: String
	public let name: String
	public let homeworld: String
	
	public init(from person: SWPeople) {
		self.id = person.id
		self.name = person.name
		self.homeworld = person.homeworld
	}
}

extension PersonListItem: CardDisplayable {
	var title: String {
		return name
	}
	
	var description: String {
		return homeworld
	}
	
	var caption: String {
		return ""
	}
}

public struct PersonDetailModel: Identifiable {
	public let id: String
	public let name: String
	public let hometown: String
	public let species: [String]
	public let films: [String]
	public let vehicles: [String]
	public let starships: [String]
	
	public init(from person: SWPeople) {
		self.id = person.id
		self.name = person.name
		self.hometown = person.homeworld
		self.species = person.species
		self.films = person.films
		self.vehicles = person.vehicles
		self.starships = person.starships
	}
}


extension SWPeopleResponse {
	public static let noop: SWPeopleResponse = .init(
		count: 0,
		next: "",
		previous: nil,
		results: []
	)
}

