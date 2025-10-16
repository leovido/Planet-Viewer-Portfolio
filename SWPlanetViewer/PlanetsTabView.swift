import SwiftUI
import StarWarsFeature

struct PlanetsTabView: View {
	@State private var selectedPill: PillSelection = .planets
	@StateObject private var planetViewModel = SWPlanetViewModel()
	@StateObject private var peopleViewModel = SWPeopleViewModel()

	var body: some View {
		NavigationStack {
			VStack {
				HeaderView(
					selectedPill: $selectedPill,
					onPlanetsTapped: {
						selectedPill = .planets
						Task {
							await planetViewModel.dispatch(.didTapPill(0))
						}
					},
					onPeopleTapped: {
						selectedPill = .people
						Task {
							await peopleViewModel.dispatch(.didTapPill(1))
						}
					}
				)
				PlanetsListView(selectedPill: selectedPill, planetViewModel: planetViewModel, peopleViewModel: peopleViewModel)
					.navigationTitle(Text("SWPlanetViewer"))
					
				Spacer()
			}
			.overlay(alignment: .top) {
				switch selectedPill {
				case .planets:
					if let error = planetViewModel.error {
						ContentUnavailableView(
							"Planet error",
							systemImage: "moon",
							description: Text("An error occured: \(error.localizedDescription)"))
					}
				case .people:
					if let error = peopleViewModel.error {
						ContentUnavailableView(
							"Person error",
							systemImage: "person",
							description: Text("An error occured: \(error.localizedDescription)"))
					}
				}
			}
			.refreshable {
				switch selectedPill {
				case .planets:
					await planetViewModel.dispatch(.refresh)
				case .people:
					await peopleViewModel.dispatch(.refresh)
				}
			}
			.onAppear {
				Task {
					await planetViewModel.dispatch(.onAppear)
				}
			}
		}
	}
}

#Preview {
	PlanetsTabView()
		.navigationTitle(Text("SWPlanetViewer"))
		.preferredColorScheme(.dark)
}
