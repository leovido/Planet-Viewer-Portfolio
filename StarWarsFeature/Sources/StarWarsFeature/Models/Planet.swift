import Foundation

public struct SWPlanetsResponse: Codable, Hashable, Sendable {
	public let count: Int
	public let next: String
	public let previous: String?
	public let planets: [SWPlanet]
	
	enum CodingKeys: String, CodingKey {
		case count, next, previous
		case planets = "results"
	}
}

public struct SWPlanet: Identifiable, Codable, Hashable, Sendable {
	public let id: String = UUID().uuidString

	public let name, rotationPeriod, orbitalPeriod, diameter: String
	public let climate, gravity, terrain, surfaceWater: String
	public let population: String
	public let residents, films: [String]
	public let created, edited: String
	public let url: String
	
	public init(name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String, climate: String, gravity: String, terrain: String, surfaceWater: String, population: String, residents: [String], films: [String], created: String, edited: String, url: String) {
		self.name = name
		self.rotationPeriod = rotationPeriod
		self.orbitalPeriod = orbitalPeriod
		self.diameter = diameter
		self.climate = climate
		self.gravity = gravity
		self.terrain = terrain
		self.surfaceWater = surfaceWater
		self.population = population
		self.residents = residents
		self.films = films
		self.created = created
		self.edited = edited
		self.url = url
	}
	
	enum CodingKeys: String, CodingKey {
		case name
		case rotationPeriod = "rotation_period"
		case orbitalPeriod = "orbital_period"
		case diameter, climate, gravity, terrain
		case surfaceWater = "surface_water"
		case population, residents, films, created, edited, url
	}
}

extension SWPlanetsResponse {
	public static var noop: SWPlanetsResponse {
		.init(count: 0, next: "", previous: nil, planets: [])
	}
}
