extension PlanetListItem: CardDisplayable {
	public typealias Model = Self
	
	public var title: String {
		return name
	}
	
	public var description: String {
		return climate
	}
	
	public var caption: String {
		return population
	}
}
