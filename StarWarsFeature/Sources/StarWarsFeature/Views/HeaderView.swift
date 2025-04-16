import SwiftUI

public struct HeaderView: View {
	@ObservedObject var viewModel: SWPlanetViewModel
	@ObservedObject var peopleViewModel: SWPeopleViewModel

	public init(viewModel: SWPlanetViewModel, peopleViewModel: SWPeopleViewModel) {
		self.viewModel = viewModel
		self.peopleViewModel = peopleViewModel
	}
	
	public var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 10) {
				Button {
					Task {
						await viewModel.dispatch(.didTapPill(0))
					}
				} label: {
					Text(LocalizedStringResource(stringLiteral: "Planets"))
						.padding(8)
						.fontDesign(.rounded)
						.background(Color.gray.opacity(0.2))
						.foregroundStyle(Color.blue)
						.clipShape(RoundedRectangle(cornerSize: .init(width: 3, height: 3)))
				}
				
				Button {
					Task {
						await viewModel.dispatch(.didTapPill(1))
					}
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
