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
		fetchFilms: @escaping () async throws -> SWFilmResponse,
		fetchPeople: @escaping () async throws -> SWPeopleResponse
	) {
		session.configuration.urlCache = URLCache()
		session.configuration.requestCachePolicy = .returnCacheDataElseLoad
		
		self.session = session
		self.fetchPlanets = fetchPlanets
		self.fetchFilms = fetchFilms
		self.fetchPeople = fetchPeople
	}
	
	public var fetchPlanets: () async throws -> SWPlanetsResponse = { fatalError("Not implemented") }
	public var fetchFilms: () async throws -> SWFilmResponse = { fatalError("Not implemented") }
	public var fetchPeople: () async throws -> SWPeopleResponse = { fatalError("Not implemented") }
}

extension SWService {
	public static let test = SWService(
		fetchPlanets: {
			.init(
				totalRecords: 7,
				next: nil,
				previous: nil,
				planets: [
					.init(
						properties: .init(
							name: "Alderaan",
							rotationPeriod: "24",
							orbitalPeriod: "364",
							diameter: "12500",
							climate: "temperate",
							gravity: "1 standard",
							terrain: "grasslands, mountains",
							surfaceWater: "40",
							population: "2000000000",
							created: "2014-12-10T11:35:48.479000Z",
							edited: "2014-12-20T20:58:18.420000Z",
							url: "https://swapi.dev/api/planets/2/"
						),
						id: "1",
						description: "",
						uid: "1",
						v: 2
					),
					.init(
						properties: .init(
							name: "Yavin IV",
							rotationPeriod: "24",
							orbitalPeriod: "4818",
							diameter: "10200",
							climate: "temperate, tropical",
							gravity: "1 standard",
							terrain: "jungle, rainforests",
							surfaceWater: "8",
							population: "1000",
							created: "2014-12-10T11:37:19.144000Z",
							edited: "2014-12-20T20:58:18.421000Z",
							url: "https://swapi.dev/api/planets/3/"
						),
						id: "3",
						description: "",
						uid: "3",
						v: 2
					)
				]
			)
		},
		fetchFilms: {
			SWFilmResponse(count: 9, next: "", previous: nil, results: [
				.init(title: "Title", episodeId: 0)
			])
		},
		fetchPeople: {
			SWPeopleResponse(
				count: 82,
				next: "https://swapi.dev/api/people/?page=2",
				previous: nil,
				results: [
					.init(
						name: "Luke Skywalker",
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
						url: "https://swapi.dev/api/people/1/"
					)
				])
		}
	)
}
