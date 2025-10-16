import Foundation

public struct PlanetListItem: Identifiable {
	public let id: String
	public let name: String
	public let climate: String
	public let population: String
	
	public init(from planet: SWPlanet) {
		self.id = planet.id
		self.name = planet.name
		self.climate = planet.climate
		self.population = planet.population
	}
	
	public init(from newPlanet: NewSWPlanet) {
		self.id = newPlanet.id
		self.name = newPlanet.properties.name
		self.climate = newPlanet.properties.climate
		self.population = newPlanet.properties.population
	}
}

extension PlanetListItem: CardDisplayable {
	var title: String {
		return name
	}
	
	var description: String {
		return climate
	}
	
	var caption: String {
		return population
	}
}

public struct PlanetDetail: Identifiable {
	public let id: String
	public let name: String
	public let climate: String
	public let population: String
	public let diameter: String
	public let gravity: String
	public let terrain: String
	
	public init(from planet: SWPlanet) {
		self.id = planet.id
		self.name = planet.name
		self.climate = planet.climate
		self.population = planet.population
		self.diameter = planet.diameter
		self.gravity = planet.gravity
		self.terrain = planet.terrain
	}
}
