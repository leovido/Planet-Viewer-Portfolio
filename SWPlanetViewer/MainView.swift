import SwiftUI
import StarWarsFeature
import Foundation

struct MainView: View {
	@StateObject private var viewModel: SWViewModel = .init()
	@StateObject private var filmViewModel: SWFilmViewModel = .init()

	var body: some View {
		ZStack {
			TabView {
				PlanetsTabView(viewModel: viewModel)
				.tabItem {
					Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
				}
				.tag(0)
				
				FilmView(viewModel: filmViewModel)
					.task {
						do {
							try await filmViewModel.fetchFilms()
						} catch {
							dump(error)
						}
					}
				.tabItem {
					Label(LocalizedStringKey("Films"), systemImage: "moon.stars")
				}
				.tag(1)
			}
			.onAppear {
				Task {
					await viewModel.dispatch(.onAppear)
				}
			}
		}
	}
}

#Preview {
	MainView()
		.preferredColorScheme(.dark)
}
