import Foundation

public enum PillSelection: CaseIterable {
    case planets
    case people
    
    public var title: String {
        switch self {
        case .planets: return "Planets"
        case .people: return "People"
        }
    }
}
