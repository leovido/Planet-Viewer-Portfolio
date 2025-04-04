import SwiftUI
import StarWarsFeature

struct PlanetCard: View {
	let planet: SWPlanet
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(planet.name)
				.font(.system(size: 24, weight: .bold, design: .rounded))
				.foregroundStyle(
					Color.black
				)
			
			Text(planet.terrain.uppercased())
				.font(.system(size: 12, weight: .black))
				.foregroundStyle(Color(.black))
				.tracking(1.5)
				.padding(4)
				.background(terrainColor(planet.terrain))
			
			HStack(spacing: 4) {
				Image(systemName: "person.3.fill")
					.font(.system(size: 10))
					.foregroundStyle(terrainColor(planet.terrain))
				
				Text("POP: \(Decimal(string: planet.population)?.formatted(.number) ?? "Unknown")")
					.font(.system(size: 14, weight: .medium))
					.foregroundStyle(Color.black.opacity(0.7))
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.vertical, 16)
		.padding(.horizontal, 20)
		.background(
			ZStack {
				RoundedRectangle(cornerRadius: 16)
					.fill(
						LinearGradient(
							colors: [
								terrainColor(planet.terrain).opacity(0.6),
								terrainColor(planet.terrain).opacity(0.2)
							],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						)
					)
				
				RoundedRectangle(cornerRadius: 16)
					.strokeBorder(
						LinearGradient(
							colors: [.white.opacity(0.3), .clear],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						),
						lineWidth: 1
					)
			}
		)
		.cornerRadius(16)
		.shadow(color: terrainColor(planet.terrain).opacity(0.3), radius: 8, x: 0, y: 4)
	}
	
	// Function to determine color based on terrain
	private func terrainColor(_ terrain: String) -> Color {
		let terrain = terrain.lowercased()
		
		if terrain.contains("desert") {
			return Color(hex: "E9B872") // Sandy orange
		} else if terrain.contains("grasslands") || terrain.contains("jungle") {
			return Color(hex: "4DAA57") // Forest green
		} else if terrain.contains("mountains") {
			return Color(hex: "9C7C72") // Mountain brown
		} else if terrain.contains("tundra") || terrain.contains("ice") {
			return Color(hex: "87CEEB") // Ice blue
		} else if terrain.contains("ocean") || terrain.contains("water") {
			return Color(hex: "1E56A0") // Deep blue
		} else if terrain.contains("city") || terrain.contains("urban") {
			return Color(hex: "6E7582") // Urban gray
		} else {
			return Color(hex: "6D5ACF") // Default purple for space
		}
	}
}

#Preview {
	PlanetCard(planet: .init(
		name: "Tatooine",
			 rotationPeriod: "23",
			 orbitalPeriod: "304",
			 diameter: "10465",
			 climate: "arid",
			 gravity: "1 standard",
			 terrain: "desert",
			 surfaceWater: "1",
			 population: "200000",
			 residents: [
				 "https://swapi.dev/api/people/1/",
				 "https://swapi.dev/api/people/2/",
				 "https://swapi.dev/api/people/4/",
				 "https://swapi.dev/api/people/6/",
				 "https://swapi.dev/api/people/7/",
				 "https://swapi.dev/api/people/8/",
				 "https://swapi.dev/api/people/9/",
				 "https://swapi.dev/api/people/11/",
				 "https://swapi.dev/api/people/43/",
				 "https://swapi.dev/api/people/62/"
			 ],
			 films: [
				 "https://swapi.dev/api/films/1/",
				 "https://swapi.dev/api/films/3/",
				 "https://swapi.dev/api/films/4/",
				 "https://swapi.dev/api/films/5/",
				 "https://swapi.dev/api/films/6/"
			 ],
			 created: "2014-12-09T13:50:49.641000Z",
			 edited: "2014-12-20T20:58:18.411000Z",
			 url: "https://swapi.dev/api/planets/1/")
	)
}
