import SwiftUI
import StarWarsFeature
import Foundation

struct MainView: View {
	var body: some View {
		ZStack {
			TabView {
				PlanetsTabView()
					.tabItem {
						Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
					}
					.tag(0)
				
				NavigationStack {
					FilmView(viewModel: .init())
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
