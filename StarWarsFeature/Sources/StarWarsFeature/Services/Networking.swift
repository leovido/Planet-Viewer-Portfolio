import Foundation

final class Networking {
	static func fetchResource<T: Decodable>(endpoint: Endpoint) async throws -> T {
		guard let url = URL(string: Constants.baseURL)?.appending(path: endpoint.rawValue) else {
			throw SWError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let response = response as? HTTPURLResponse,
					(200...399).contains(response.statusCode) else {
			throw SWError.invalidResponse
		}
		
		return try SWJSONDecoder.decoder.decode(T.self, from: data)
	}	
}
