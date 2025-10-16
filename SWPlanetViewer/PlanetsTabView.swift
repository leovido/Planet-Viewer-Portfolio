import SwiftUI
import StarWarsFeature

struct PlanetsTabView: View {
	@ObservedObject var coordinator: SWCoordinator

	var body: some View {
		NavigationStack {
			VStack {
				HeaderView(coordinator: coordinator)
				PlanetsListView(coordinator: coordinator)
					.navigationTitle(Text("SWPlanetViewer"))
					
				Spacer()
			}
			.overlay(alignment: .top) {
				switch coordinator.selectedPill {
				case .planets:
					if let error = coordinator.planetViewModel.error {
						ContentUnavailableView(
							"Planet error",
							systemImage: "moon",
							description: Text("An error occured: \(error.localizedDescription)"))
					}
				case .people:
					if let error = coordinator.peopleViewModel.error {
						ContentUnavailableView(
							"Person error",
							systemImage: "person",
							description: Text("An error occured: \(error.localizedDescription)"))
					}
				}
			}
			.refreshable {
				switch coordinator.selectedPill {
				case .planets:
					await coordinator.planetViewModel.dispatch(.refresh)
				case .people:
					await coordinator.peopleViewModel.dispatch(.refresh)
				}
			}
			.onAppear {
				Task {
					await coordinator.planetViewModel.dispatch(.onAppear)
				}
			}
		}
	}
}

#Preview {
	@ObservedObject var coordinator: SWCoordinator = .init(
		planetViewModel: .init(),
		peopleViewModel: .init()
	)
	
	PlanetsTabView(coordinator: coordinator)
		.navigationTitle(Text("SWPlanetViewer"))
		.onAppear {
			Task {
				await coordinator.planetViewModel.dispatch(.onAppear)
			}
		}
		.preferredColorScheme(.dark)
}

#Preview {
	@ObservedObject var coordinator: SWCoordinator = .init(
		planetViewModel: .init(
			error: SWError.message("Planet error"),
		 service: SWService.test
	 ),
		peopleViewModel: .init()
	)
	
	PlanetsTabView(coordinator: coordinator)
		.navigationTitle(Text("SWPlanetViewer"))
		.preferredColorScheme(.dark)
}
