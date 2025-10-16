import SwiftUI

public struct PlanetsListView: View {
	let selectedPill: PillSelection
	@ObservedObject var planetViewModel: SWPlanetViewModel
	@ObservedObject var peopleViewModel: SWPeopleViewModel
	
	public init(
		selectedPill: PillSelection,
		planetViewModel: SWPlanetViewModel,
		peopleViewModel: SWPeopleViewModel
	) {
		self.selectedPill = selectedPill
		self.planetViewModel = planetViewModel
		self.peopleViewModel = peopleViewModel
	}
	
	public var body: some View {
		Group {
			ScrollView {
				LazyVStack(spacing: 0) {
					SomeView()
				}
			}
		}
		.overlay(content: {
			if planetViewModel.isLoading {
				VStack {
					Spacer()
					ProgressView()
					Spacer()
				}
			}
		})
	}
	
	@ViewBuilder
	func SomeView() -> some View {
		switch selectedPill {
		case .planets:
			ForEach(planetViewModel.planetListItems) { planet in
				NavigationLink(
					destination: PlanetDetailView(
						viewModel: SWPlanetDetailViewModel(
							planet: planetViewModel.model.planets
								.first(where: { $0.id == planet.id }) ?? .default
						)
					)
				) {
					CardView(model: planet)
				}
				.padding(.vertical, 4)
			}
		case .people:
			ForEach(peopleViewModel.peopleListItems) { person in
				NavigationLink(
					destination: PersonDetailView(
						viewModel: SWPersonDetailViewModel(
							person: peopleViewModel.model.results
								.first(where: { $0.id == person.id })!)
					)
				) {
					CardView(model: person)
				}
				.padding(.vertical, 4)
			}
		}
	}
}

#Preview {
	PlanetsListView(
		selectedPill: .planets,
		planetViewModel: SWPlanetViewModel(service: SWService.test),
		peopleViewModel: SWPeopleViewModel()
	)
		.task {
			await SWPlanetViewModel(service: SWService.test).dispatch(.onAppear)
		}
		.preferredColorScheme(.dark)
}
