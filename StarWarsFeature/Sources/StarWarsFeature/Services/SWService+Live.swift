import Foundation

extension SWService {
	public static let live = SWService(
		fetchPlanets: {
			try await Networking.fetchResource(endpoint: .planets)
		},
		fetchFilms: {
			try await Networking.fetchResource(endpoint: .films)
		},
		fetchPeople: {
			try await Networking.fetchResource(endpoint: .people)
		}
	)
}
