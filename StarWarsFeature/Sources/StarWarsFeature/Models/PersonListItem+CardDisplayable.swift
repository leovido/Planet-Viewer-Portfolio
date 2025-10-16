extension PersonListItem: CardDisplayable {
	public typealias Model = Self
	
	public var title: String {
		return name
	}
	
	public var description: String {
		return "# of films: \(numberOfFilms.description)"
	}
	
	public var caption: String {
		return hairColor
	}
}
