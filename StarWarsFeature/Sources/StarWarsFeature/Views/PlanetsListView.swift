import SwiftUI

public struct PlanetsListView: View {
	@ObservedObject private var viewModel: SWViewModel
	
	public init(viewModel: SWViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		Group {
			ScrollView {
				ForEach(viewModel.planetListItems) { planet in
					NavigationLink(
						destination: PlanetDetailView(
							viewModel: SWPlanetDetailViewModel(
								planet: viewModel.model.planets
									.first(where: { $0.id == planet.id }) ?? SWPlanet.default)
						)
					) {
						PlanetCard(planet: planet)
					}
					.padding(.vertical, 4)
				}
			}
		}
		.overlay(content: {
			if viewModel.isLoading {
				VStack {
					Spacer()
					ProgressView()
					Spacer()
				}
			}
		})
	}
}

#Preview {
	PlanetsListView(viewModel: .init(service: SWService.test))
}
