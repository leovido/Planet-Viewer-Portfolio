import SwiftUI

public enum PillSelection {
	case planets
	case people
}

@MainActor
public final class SWCoordinator: ObservableObject {
	@Published public var planetViewModel: SWPlanetViewModel
	@Published public var peopleViewModel: SWPeopleViewModel
	
	@Published public var selectedTab: Int = 0
	@Published public var selectedPill: PillSelection = .planets
	
	public init(
		planetViewModel: SWPlanetViewModel,
		peopleViewModel: SWPeopleViewModel
	) {
		self.planetViewModel = planetViewModel
		self.peopleViewModel = peopleViewModel
	}
}
