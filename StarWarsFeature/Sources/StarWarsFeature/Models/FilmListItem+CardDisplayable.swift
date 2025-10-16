extension FilmListItem: CardDisplayable {
	public typealias Model = Self
	
	public var description: String {
		return director
	}
	
	public var caption: String {
		return releaseDate
	}
}
