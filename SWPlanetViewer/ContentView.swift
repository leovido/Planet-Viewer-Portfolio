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
					VStack {
						ScrollView(.horizontal) {
							HStack(spacing: 10) {
								Button {
									viewModel.action.send(.didTapPill(0))
								} label: {
									Text("Planets")
										.padding(5)
										.fontDesign(.rounded)
										.background(Color.gray.opacity(0.2))
										.foregroundStyle(Color.black)
										.clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
								}
								
								Button {
									viewModel.action.send(.didTapPill(1))
								} label: {
									Text("People")
										.padding(5)
										.fontDesign(.rounded)
										.background(Color.gray.opacity(0.2))
										.foregroundStyle(Color.black)
										.clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
								}
							}
							.padding()
						}
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
				
				Text("Favorites")
					.tabItem {
						Label("Favorites", systemImage: "star")
					}
					.tag(1)
				
				VStack {
					Text("Settings")
				}
				.tabItem {
					Label(LocalizedStringKey("Settings"), systemImage: "gearshape")
				}
				.tag(2)
			}
			
			//			if showCrawl {
			//				StarWarsCrawlView()
			//					.opacity(crawlOpacity)
			//					.animation(.easeInOut(duration: 1.0), value: crawlOpacity)
			//					.zIndex(10)
			//			}
		}
		//		.onChange(of: showCrawl, { _, newValue in
		//			if newValue == false {
		//				viewModel.action.send(.onAppear)
		//			}
		//		})
		.onAppear {
			viewModel.action.send(.onAppear)
			//			showCrawl = true
			//
			//			DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
			//				withAnimation {
			//					crawlOpacity = 0.0
			//				}
			//			}
			//
			//			DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
			//				showCrawl = false
			//			}
		}
	}
}

#Preview {
	ContentView()
}
