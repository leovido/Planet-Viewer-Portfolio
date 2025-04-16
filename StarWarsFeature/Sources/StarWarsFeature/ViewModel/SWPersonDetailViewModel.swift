import SwiftUI

@MainActor
public final class SWPersonDetailViewModel: ObservableObject {
	private let person: SWPeople
	
	@Published public var name: String = ""
	@Published public var height: String = ""
	@Published public var mass: String = ""
	@Published public var hairColor: String = ""
	@Published public var skinColor: String = ""
	@Published public var gender: String = ""
	
	public enum DetailAction: Equatable {
		case loadPerson(String)
	}
	
	public init(person: SWPeople) {
		self.person = person
		self.updateDetailState(with: person)
	}
	
	private func updateDetailState(with person: SWPeople) {
		self.name = person.name
		self.height = person.height
		self.mass = person.mass
		self.hairColor = person.hairColor
		self.skinColor = person.skinColor
		self.gender = person.gender
	}
}
