import SwiftUI
import StarWarsFeature

struct HeaderView: View {
	@ObservedObject var viewModel: SWViewModel
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 10) {
				Button {
					viewModel.action.send(.didTapPill(0))
				} label: {
					Text(LocalizedStringResource(stringLiteral: "Planets"))
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
