import SwiftUI

public struct FilmCardView<T: CardDisplayable>: View where T.Model == FilmListItem {
	let model: T
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(model.title)
				.font(.system(size: 24, weight: .bold, design: .rounded))
				.foregroundStyle(Color.white)
				.background(Color.black)
			
			Text(model.description.uppercased())
				.font(.system(size: 12, weight: .black))
				.foregroundStyle(Color.white)
				.tracking(1.5)
				.padding(4)
				.background(Color.black)
			
			if !model.caption.isEmpty {
				HStack(spacing: 4) {
					Image(systemName: "film.fill")
						.font(.system(size: 10))
					
					Text("\(model.caption)")
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
	FilmCardView(model: FilmListItem(from: NewSWFilm(properties: .default, id: "", description: "", uid: "", v: 1)))
		.padding()
		.preferredColorScheme(.dark)
}
