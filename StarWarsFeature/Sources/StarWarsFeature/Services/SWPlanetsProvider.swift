public protocol SWPlanetsProvider {
	var fetchPlanets: () async throws -> PlanetsResponse { get }
}
