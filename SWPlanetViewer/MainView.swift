import SwiftUI
import StarWarsFeature
import Foundation

struct MainView: View {
	@StateObject private var viewModel: SWViewModel = .init()
	
	var body: some View {
		ZStack {
			TabView {
				PlanetsTabView(viewModel: viewModel)
				.tabItem {
					Label(LocalizedStringKey("Planets"), systemImage: "moon.stars")
				}
				.tag(0)
			}
			.onAppear {
				viewModel.dispatch(.onAppear)
			}
		}
	}
}

#Preview {
	MainView()
		.preferredColorScheme(.dark)
}
