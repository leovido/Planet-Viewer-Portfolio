import SwiftUI

public struct HeaderView: View {
	@ObservedObject var coordinator: SWCoordinator

	public init(coordinator: SWCoordinator) {
		self.coordinator = coordinator
	}
	
	public var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 10) {
				Button {
					coordinator.selectedPill = .planets
					Task {
						await coordinator.planetViewModel.dispatch(.didTapPill(0))
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
					coordinator.selectedPill = .people
					Task {
						await coordinator.peopleViewModel.dispatch(.didTapPill(1))
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
