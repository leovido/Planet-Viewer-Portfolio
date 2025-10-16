import SwiftUI

public struct HeaderView: View {
	@Binding var selectedPill: PillSelection
	let onPlanetsTapped: () -> Void
	let onPeopleTapped: () -> Void

	public init(
		selectedPill: Binding<PillSelection>,
		onPlanetsTapped: @escaping () -> Void,
		onPeopleTapped: @escaping () -> Void
	) {
		self._selectedPill = selectedPill
		self.onPlanetsTapped = onPlanetsTapped
		self.onPeopleTapped = onPeopleTapped
	}
	
	public var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 10) {
				Button {
					selectedPill = .planets
					onPlanetsTapped()
				} label: {
					Text(LocalizedStringResource(stringLiteral: "Planets"))
						.padding(8)
						.fontDesign(.rounded)
						.background(Color.gray.opacity(0.2))
						.foregroundStyle(Color.blue)
						.clipShape(RoundedRectangle(cornerSize: .init(width: 3, height: 3)))
				}
				
				Button {
					selectedPill = .people
					onPeopleTapped()
				} label: {
					Text(LocalizedStringResource(stringLiteral: "People"))
						.padding(8)
						.fontDesign(.rounded)
						.background(Color.gray.opacity(0.2))
						.foregroundStyle(Color.blue)
						.clipShape(RoundedRectangle(cornerSize: .init(width: 3, height: 3)))
				}
			}
			.padding()
		}
	}
}
