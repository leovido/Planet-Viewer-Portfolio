import SwiftUI
import StarWarsFeature
import Foundation

struct MainView: View {
	@StateObject private var coordinator: SWCoordinator = .init(
		planetViewModel: .init(),
		peopleViewModel: .init()
	)
	@StateObject private var filmViewModel: SWFilmViewModel = .init()
	
	var body: some View {
		ZStack {
			TabView {
				PlanetsTabView(coordinator: coordinator)
					.tabItem {
						Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
					}
					.tag(0)
				
				NavigationStack {
					FilmView(viewModel: filmViewModel)
						.task {
							do {
								try await filmViewModel.fetchFilms()
							} catch {
								dump(error)
							}
						}
				}
				.tabItem {
					Label(LocalizedStringKey("Films"), systemImage: "film")
				}
				.tag(1)
			}
			.task {
				await coordinator.planetViewModel.dispatch(.onAppear)
			}
		}
	}
}

#Preview {
	MainView()
		.preferredColorScheme(.dark)
}
