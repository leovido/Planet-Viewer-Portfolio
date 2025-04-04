public protocol SWPlanetsProvider {
	var fetchPlanets: () async throws -> SWPlanetsResponse { get }
	var fetchPeople: () async throws -> SWPeopleResponse { get }
}
