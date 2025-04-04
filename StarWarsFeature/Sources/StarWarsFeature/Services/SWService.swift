import Foundation

public final class SWService: SWPlanetsProvider {
	private let session: URLSession
	
	public init(
		session: URLSession = .init(
			configuration: .default,
			delegate: nil,
			delegateQueue: nil
		),
		fetchPlanets: @escaping () async throws -> SWPlanetsResponse,
		fetchPeople: @escaping () async throws -> SWPeopleResponse
	) {
		session.configuration.urlCache = URLCache()
		session.configuration.requestCachePolicy = .returnCacheDataElseLoad
		
		self.session = session
		self.fetchPlanets = fetchPlanets
		self.fetchPeople = fetchPeople
	}
	
	public var fetchPlanets: () async throws -> SWPlanetsResponse = { fatalError("Not implemented") }
	public var fetchPeople: () async throws -> SWPeopleResponse = { fatalError("Not implemented") }
	
}

extension SWService {
	public static let test = SWService {
		.init(
			count: 1,
			next: "https://swapi.dev/api/planets/?page=2",
			previous: nil,
			planets: [
				.init(
					name: "Tatooine",
					rotationPeriod: "23",
					orbitalPeriod: "304",
					diameter: "10465",
					climate: "arid",
					gravity: "1 standard",
					terrain: "desert",
					surfaceWater: "1",
					population: "200000",
					residents: [
						"https://swapi.dev/api/people/1/",
						"https://swapi.dev/api/people/2/",
						"https://swapi.dev/api/people/4/",
						"https://swapi.dev/api/people/6/",
						"https://swapi.dev/api/people/7/",
						"https://swapi.dev/api/people/8/",
						"https://swapi.dev/api/people/9/",
						"https://swapi.dev/api/people/11/",
						"https://swapi.dev/api/people/43/",
						"https://swapi.dev/api/people/62/"
					],
					films: [
						"https://swapi.dev/api/films/1/",
						"https://swapi.dev/api/films/3/",
						"https://swapi.dev/api/films/4/",
						"https://swapi.dev/api/films/5/",
						"https://swapi.dev/api/films/6/"
					],
					created: "2014-12-09T13:50:49.641000Z",
					edited: "2014-12-20T20:58:18.411000Z",
					url: "https://swapi.dev/api/planets/1/")
			]
		)
	} fetchPeople: {
		SWPeopleResponse(
			count: 82,
			next: "https://swapi.dev/api/people/?page=2",
			previous: nil,
			results: [
				.init(name: "Luke Skywalker",
							height: "172",
							mass: "77",
							hairColor: "blond",
							skinColor: "fair",
							eyeColor: "blue",
							birthYear: "19BBY",
							gender: "male",
							homeworld: "https://swapi.dev/api/planets/1/",
							films: [
								"https://swapi.dev/api/films/1/",
								"https://swapi.dev/api/films/2/",
								"https://swapi.dev/api/films/3/",
								"https://swapi.dev/api/films/6/"
							],
							species: [],
							vehicles: [
								"https://swapi.dev/api/vehicles/14/",
								"https://swapi.dev/api/vehicles/30/"
							],
							starships: [
								"https://swapi.dev/api/starships/12/",
								"https://swapi.dev/api/starships/22/"
							],
							created: "2014-12-09T13:50:51.644000Z",
							edited: "2014-12-20T21:17:56.891000Z",
							url: "https://swapi.dev/api/people/1/")
			])
	}
}
