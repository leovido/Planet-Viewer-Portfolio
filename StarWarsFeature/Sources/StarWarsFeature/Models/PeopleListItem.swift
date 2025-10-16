import Foundation

public struct PersonListItem: Identifiable {
	public let id: String
	public let name: String
	public let numberOfFilms: Int
	public let hairColor: String

	public init(from person: SWPeople) {
		self.id = UUID().uuidString
		self.name = person.name
		self.numberOfFilms = person.films.count
		self.hairColor = person.hairColor
	}
}
