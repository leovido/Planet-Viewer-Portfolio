import Foundation

public struct SWFilmResponse: Codable, Hashable, Sendable {
	public let message: String?
	public let totalRecords: Int
	public let totalPages: Int?
	public let next: String?
	public let previous: String?
	public let apiVersion: String?
	public let timestamp: String?
	public let results: [SWFilm]
	
	public init(
		message: String?,
		totalRecords: Int,
		totalPages: Int?,
		next: String?,
		previous: String?,
		apiVersion: String?,
		timestamp: String?,
		results: [SWFilm]
	) {
		self.message = message
		self.totalRecords = totalRecords
		self.totalPages = totalPages
		self.next = next
		self.previous = previous
		self.apiVersion = apiVersion
		self.timestamp = timestamp
		self.results = results
	}
	
	enum CodingKeys: String, CodingKey {
		case message
		case totalRecords = "total_records"
		case totalPages = "total_pages"
		case next, previous
		case apiVersion
		case timestamp
		case results
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

extension SWFilmResponse {
	public static var noop: SWFilmResponse {
		.init(message: nil,
			  totalRecords: 0,
			  totalPages: nil,
			  next: nil,
			  previous: nil,
			  apiVersion: nil,
			  timestamp: nil,
			  results: [])
	}
}
