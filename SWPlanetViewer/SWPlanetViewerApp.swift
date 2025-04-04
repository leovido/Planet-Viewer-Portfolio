import SwiftUI

@main
struct SWPlanetViewerApp: App {
	var body: some Scene {
		WindowGroup {
			MainView()
				.preferredColorScheme(.dark)
		}
	}
}
