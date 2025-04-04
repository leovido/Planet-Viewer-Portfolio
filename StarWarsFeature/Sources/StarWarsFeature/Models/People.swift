import Foundation

public struct SWPeopleResponse: Codable, Sendable {
	public let count: Int
	public let next: String
	public let previous: String?
	public let results: [SWPeople]
}

public struct SWPeople: Codable, Sendable {
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

extension SWPeopleResponse {
	public static let noop: SWPeopleResponse = .init(
		count: 0,
		next: "",
		previous: nil,
		results: []
	)
}
