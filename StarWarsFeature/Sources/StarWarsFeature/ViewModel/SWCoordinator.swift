import SwiftUI

public enum PillSelection {
	case planets
	case people
}

@MainActor
public final class SWCoordinator: ObservableObject {
	public let planetViewModel: SWPlanetViewModel
	public let peopleViewModel: SWPeopleViewModel
	
	@Published public var selectedTab: Int = 0
	@Published public var selectedPill: PillSelection = .planets
	
	public init(
		planetViewModel: SWPlanetViewModel,
		peopleViewModel: SWPeopleViewModel
	) {
		self.planetViewModel = SWPlanetViewModel()
		self.peopleViewModel = SWPeopleViewModel()
	}
}
