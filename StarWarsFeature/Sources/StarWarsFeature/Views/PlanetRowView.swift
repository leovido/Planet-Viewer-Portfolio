import SwiftUI

public struct PlanetRowView: View {
	let planet: SWPlanet
	
	public var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(planet.name)
					.font(.headline)
				Text("\(planet.terrain.uppercased())")
					.font(.subheadline)
					.foregroundColor(.gray)
				Text("Pop: \(planet.population)")
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

#Preview(traits: .sizeThatFitsLayout) {
	PlanetRowView(planet: .default)
}
