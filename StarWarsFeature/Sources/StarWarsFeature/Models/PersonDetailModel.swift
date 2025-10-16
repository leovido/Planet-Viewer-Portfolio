import Foundation.NSUUID

public struct PersonDetailModel: Identifiable {
	public let id: String
	public let name: String
	public let hometown: String
	public let films: [String]
	public let vehicles: [String]
	public let starships: [String]
	
	public init(from person: SWPeople) {
		self.id = UUID().uuidString
		self.name = person.name
		self.hometown = person.homeworld
		self.films = person.films
		self.vehicles = person.vehicles
		self.starships = person.starships
	}
}
