import SwiftUI
import StarWarsFeature

struct PlanetsListView: View {
	@ObservedObject private var viewModel: SWViewModel
	
	init(viewModel: SWViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		Group {
			ScrollView {
				ForEach(viewModel.model.planets) { planet in
					NavigationLink(destination: PlanetDetailView(planet: planet)) {
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
