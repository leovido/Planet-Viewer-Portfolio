import Foundation.NSUUID

public struct FilmListItem: Identifiable {
	public var id: String = UUID().uuidString
	public var title: String
	public var releaseDate: String
	public var director: String
	
	public init(title: String, releaseDate: String, director: String) {
		self.title = title
		self.releaseDate = releaseDate
		self.director = director
	}
	
	public init(from film: NewSWFilm) {
		self.title = film.properties.title
		self.releaseDate = film.properties.releaseDate
		self.director = film.properties.director
	}
}
