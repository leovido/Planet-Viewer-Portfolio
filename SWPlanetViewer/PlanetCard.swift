import SwiftUI
import StarWarsFeature

struct PlanetCard: View {
	let planet: PlanetListItem
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(planet.name)
				.font(.system(size: 24, weight: .bold, design: .rounded))
				.foregroundStyle(Color.white)
			
			Text(planet.climate.uppercased())
				.font(.system(size: 12, weight: .black))
				.foregroundStyle(Color.white)
				.tracking(1.5)
				.padding(4)

			HStack(spacing: 4) {
				Image(systemName: "person.3.fill")
					.font(.system(size: 10))
				
				Text("POP: \(planet.population)")
					.font(.system(size: 14, weight: .medium))
					.foregroundStyle(Color.white.opacity(0.7))
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.vertical, 16)
		.padding(.horizontal, 20)
		.background(
			ZStack {
				RoundedRectangle(cornerRadius: 16)
					.strokeBorder(
						LinearGradient(
							colors: [.white.opacity(0.8), .clear],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						),
						lineWidth: 1
					)
			}
		)
		.cornerRadius(16)
	}
}

#Preview(traits: .sizeThatFitsLayout) {
	PlanetCard(planet: .init(from: .default))
		.padding()
		.preferredColorScheme(.dark)
}
