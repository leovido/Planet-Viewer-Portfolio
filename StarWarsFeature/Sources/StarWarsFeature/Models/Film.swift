import Foundation

public struct SWFilmResponse: Codable, Sendable {
	public let count: Int
	public let next: String?
	public let previous: String?
	public let results: [SWFilm]
}

public struct SWFilm: Identifiable, Codable, Sendable {
	public let id: String = UUID().uuidString
	public let title: String
	public let episodeId: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case episodeId = "episode_id"
	}
}

extension SWFilmResponse {
	public static var noop: SWFilmResponse {
		.init(count: 0, next: "", previous: nil, results: [])
	}
}
