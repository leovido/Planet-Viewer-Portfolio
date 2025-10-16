import Foundation

public final class SWService: SWAPIProvider {
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
				message: "ok",
				totalRecords: 7,
				totalPages: 1,
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
				],
				apiVersion: "1.0",
				timestamp: "2025-10-16T03:32:32.247Z"
			)
		},
		fetchFilms: {
			.init(message: "ok",
				  totalRecords: 10,
				  totalPages: 1,
				  next: nil,
				  previous: nil,
				  apiVersion: nil,
				  timestamp: nil,
				  results: [
					.init(title: "A New Hope", director: "George Lucas", releaseDate: "1977-05-25")
				  ])
		},
		fetchPeople: {
			SWPeopleResponse(
				message: "ok",
				totalRecords: 82,
				totalPages: 1,
				next: "https://swapi.dev/api/people/?page=2",
				previous: nil,
				apiVersion: "1.0",
				timestamp: "2025-10-16T03:32:32.247Z",
				results: [.init(
					properties: .default,
					id: "1",
					description: "",
					uid: "",
					v: 1
				)]
			)
		}
	)
}
