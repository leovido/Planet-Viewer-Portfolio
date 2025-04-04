import Combine
import SwiftUI

public final class SWPlanetDetailViewModel: ObservableObject {
	private let planet: SWPlanet
	
	@Published public var planetName: String = ""
	@Published public var climate: String = ""
	@Published public var population: String = ""
	@Published public var diameter: String = ""
	@Published public var gravity: String = ""
	@Published public var terrain: String = ""
	
	public enum DetailAction: Equatable {
		case loadPlanet(String)
	}
	
	public init(planet: SWPlanet) {
		self.planet = planet
		self.updateDetailState(with: planet)
	}
	
	private func updateDetailState(with planet: SWPlanet) {
		planetName = planet.name
		population = planet.population
		climate = planet.climate
		diameter = planet.diameter
		gravity = planet.gravity
		terrain = planet.terrain
	}
}
