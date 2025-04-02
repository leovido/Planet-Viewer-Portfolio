import SwiftUI
import StarWarsFeature

struct ContentView: View {
	@StateObject private var viewModel: SWViewModel = .init()
	@State private var showCrawl = false
	@State private var crawlOpacity = 1.0
	
	var body: some View {
		ZStack {
			TabView {
				NavigationStack {
					List(viewModel.model.planets) { planet in
						NavigationLink(destination: PlanetDetailView(planet: planet)) {
							Text(planet.name)
						}
					}
					.navigationTitle(Text("SWPlanetViewer"))
				}
				.tabItem {
					Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
				}
				
				Text("Favorites")
					.tabItem {
						Label("Favorites", systemImage: "star")
					}
				
				VStack {
					Text("Settings")
				}
				.tabItem {
					Label(LocalizedStringKey("Settings"), systemImage: "gearshape")
				}
			}
			
			if showCrawl {
				StarWarsCrawlView()
					.opacity(crawlOpacity)
					.animation(.easeInOut(duration: 1.0), value: crawlOpacity)
					.zIndex(10)
			}
		}
		.onAppear {
			viewModel.action.send(.onAppear)
			
			showCrawl = true
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
				withAnimation {
					crawlOpacity = 0.0
				}
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
				showCrawl = false
			}
		}
	}
}

#Preview {
	ContentView()
}
