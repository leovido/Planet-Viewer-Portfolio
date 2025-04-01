import Foundation

public struct PlanetsResponse: Identifiable, Codable, Hashable, Sendable {
	public var id: String = UUID().uuidString
	public let count: Int
	public let next: String
	public let previous: String?
	public let planets: [Planet]
	
	enum CodingKeys: String, CodingKey {
		case count, next, previous
		case planets = "results"
	}
}

public struct Planet: Codable, Hashable, Sendable {
	public let name, rotationPeriod, orbitalPeriod, diameter: String
	public let climate, gravity, terrain, surfaceWater: String
	public let population: String
	public let residents, films: [String]
	public let created, edited: String
	public let url: String
	
	enum CodingKeys: String, CodingKey {
		case name
		case rotationPeriod = "rotation_period"
		case orbitalPeriod = "orbital_period"
		case diameter, climate, gravity, terrain
		case surfaceWater = "surface_water"
		case population, residents, films, created, edited, url
	}
}
