import SwiftUI
import StarWarsFeature
import Foundation

struct MainView: View {
	@StateObject private var filmViewModel: SWFilmViewModel = .init()
	
	var body: some View {
		ZStack {
			TabView {
				PlanetsTabView()
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
		}
	}
}

#Preview {
	MainView()
		.preferredColorScheme(.dark)
}
