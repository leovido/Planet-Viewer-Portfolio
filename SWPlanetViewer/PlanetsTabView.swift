import SwiftUI
import StarWarsFeature

struct PlanetsTabView: View {
	@ObservedObject var viewModel: SWViewModel
	
	var body: some View {
		NavigationStack {
			VStack {
				HeaderView(viewModel: viewModel)
				PlanetsListView(viewModel: viewModel)
					.navigationTitle(Text("SWPlanetViewer"))
				
				Spacer()
			}
			.background(Color.black)
			.refreshable {
				viewModel.dispatch(.refresh)
			}
		}
	}
}

#Preview {
	@ObservedObject var viewModel: SWViewModel = .init(service: SWService.test)
	
	PlanetsTabView(viewModel: viewModel)
		.navigationTitle(Text("SWPlanetViewer"))
		.onAppear {
			viewModel.dispatch(.onAppear)
		}
		.preferredColorScheme(.dark)
}
