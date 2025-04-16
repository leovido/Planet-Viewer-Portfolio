import SwiftUI

protocol CardDisplayable {
	var title: String { get }
	var description: String { get }
	var caption: String { get }
}

struct CardView<T: CardDisplayable>: View {
	let model: T
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(model.title)
				.font(.system(size: 24, weight: .bold, design: .rounded))
				.foregroundStyle(Color.white)
			
			Text(model.description.uppercased())
				.font(.system(size: 12, weight: .black))
				.foregroundStyle(Color.white)
				.tracking(1.5)
				.padding(4)

			if !model.caption.isEmpty {
				HStack(spacing: 4) {
					Image(systemName: "person.3.fill")
						.font(.system(size: 10))
					
					Text("POP: \(model.caption)")
						.font(.system(size: 14, weight: .medium))
						.foregroundStyle(Color.white.opacity(0.7))
				}
			} else {
				EmptyView()
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
	CardView(model: PlanetListItem(from: SWPlanet.default))
		.padding()
		.preferredColorScheme(.dark)
}
