import Foundation

public struct SWFilmResponse: Codable, Hashable, Sendable {
	public let message: String?
	public let result: [NewSWFilm]
	
	public init(
		message: String?,
		result: [NewSWFilm]
	) {
		self.message = message
		self.result = result
	}
	
	enum CodingKeys: String, CodingKey {
		case message
		case result
	}
}

public struct NewSWFilm: Codable, Hashable, Sendable {
	public let properties: SWFilm
	public let id: String
	public let description: String
	public let uid: String
	public let v: Int
	
	public init(properties: SWFilm, id: String, description: String, uid: String, v: Int) {
		self.properties = properties
		self.id = id
		self.description = description
		self.uid = uid
		self.v = v
	}
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case properties
		case description, uid
		case v = "__v"
	}
}

public struct SWFilm: Identifiable, Hashable, Codable, Sendable {
	public let id: String = UUID().uuidString
	public let title: String
	public let director: String
	public let releaseDate: String
	
	enum CodingKeys: String, CodingKey {
		case title
		case director
		case releaseDate = "release_date"
	}
}

extension SWFilm {
	public static var `default`: SWFilm {
		.init(title: "Star Wars: Episode IV - A New Hope",
			  director: "George Lucas",
			  releaseDate: "1977-05-25")
	}
}

extension SWFilmResponse {
	public static var noop: SWFilmResponse {
		.init(message: nil,
			  result: [])
	}
}
