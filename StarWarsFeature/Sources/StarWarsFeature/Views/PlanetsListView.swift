import SwiftUI

public struct PlanetsListView: View {
	@ObservedObject private var coordinator: SWCoordinator
	
	public init(coordinator: SWCoordinator) {
		self.coordinator = coordinator
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
			if coordinator.planetViewModel.isLoading {
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
		switch coordinator.selectedPill {
		case .planets:
			ForEach(coordinator.planetViewModel.planetListItems) { planet in
				NavigationLink(
					destination: PlanetDetailView(
						viewModel: SWPlanetDetailViewModel(
							planet: coordinator.planetViewModel.model.planets
								.first(where: { $0.id == planet.id }) ?? .default
						)
					)
				) {
					CardView(model: planet)
				}
				.padding(.vertical, 4)
			}
		case .people:
			ForEach(coordinator.peopleViewModel.peopleListItems) { person in
				NavigationLink(
					destination: PersonDetailView(
						viewModel: SWPersonDetailViewModel(
							person: coordinator.peopleViewModel.model.results
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
	@ObservedObject var coordinator: SWCoordinator = .init(
		planetViewModel: .init(service: SWService.test),
		peopleViewModel: .init()
	)
	
	PlanetsListView(coordinator: coordinator)
		.task {
			await coordinator.planetViewModel.dispatch(.onAppear)
		}
		.preferredColorScheme(.dark)
}
