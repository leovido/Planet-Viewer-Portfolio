import SwiftUI

public struct HeaderView: View {
	@ObservedObject var viewModel: SWViewModel
	
	public init(viewModel: SWViewModel) {
		self.viewModel = viewModel
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
			}
			.padding()
		}
	}
}
