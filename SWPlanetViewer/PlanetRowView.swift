import SwiftUI
import StarWarsFeature

struct PlanetRowView: View {
	let planet: SWPlanet
	
	var populationFormatted: String {
		Decimal(string: planet.population)?.formatted(.number) ?? "N/A"
	}
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(planet.name)
					.font(.headline)
				Text("\(planet.terrain.uppercased())")
					.font(.subheadline)
					.foregroundColor(.gray)
				Text("Pop: \(populationFormatted)")
					.font(.subheadline)
					.foregroundColor(.gray)
			}
			Spacer()
		}
		.padding()
		.background(Color(.systemGray6))
		.cornerRadius(8)
	}
}
