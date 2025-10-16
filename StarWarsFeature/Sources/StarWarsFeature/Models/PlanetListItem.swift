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

