import SwiftUI
import StarWarsFeature
import Combine
import Foundation

struct ContentView: View {
	@StateObject private var viewModel: SWViewModel = .init()
	
	var body: some View {
		ZStack {
			TabView {
				NavigationStack {
					VStack {
						HeaderView(viewModel: viewModel)
						PlanetsListView(viewModel: viewModel)
							.navigationTitle(Text("SWPlanetViewer"))
						
						Spacer()
					}
					.background(Color.black)
					.refreshable {
						viewModel.action.send(.refresh)
					}
				}
				.tabItem {
					Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
				}
				.tag(0)
			}
			.onAppear {
				viewModel.action.send(.onAppear)
			}
		}
	}
}

#Preview {
	ContentView()
}
