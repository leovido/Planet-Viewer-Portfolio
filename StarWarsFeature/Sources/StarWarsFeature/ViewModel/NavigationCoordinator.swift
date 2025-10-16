import SwiftUI

public enum PillSelection: CaseIterable {
    case planets
    case people
    
    var title: String {
        switch self {
        case .planets: return "Planets"
        case .people: return "People"
        }
    }
}

@MainActor
public final class NavigationCoordinator: ObservableObject {
    @Published public var selectedTab: Int = 0
    @Published public var selectedPill: PillSelection = .planets
    @Published public var navigationPath = NavigationPath()
    
    public init() {}
    
    // MARK: - Navigation Actions
    
    public func selectTab(_ tab: Int) {
        selectedTab = tab
    }
    
    public func selectPill(_ pill: PillSelection) {
        selectedPill = pill
    }
    
    public func navigateToPlanetDetail(planetId: String) {
        navigationPath.append(PlanetDetailDestination(planetId: planetId))
    }
    
    public func navigateToPersonDetail(personId: String) {
        navigationPath.append(PersonDetailDestination(personId: personId))
    }
    
    public func navigateBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    public func navigateToRoot() {
        navigationPath = NavigationPath()
    }
}

// MARK: - Navigation Destinations

public struct PlanetDetailDestination: Hashable {
    let planetId: String
}

public struct PersonDetailDestination: Hashable {
    let personId: String
}
