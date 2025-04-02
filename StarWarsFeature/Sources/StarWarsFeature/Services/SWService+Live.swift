import Foundation

extension SWService {
	public static let live = SWService {
		guard let url = URL(string: Constants.baseURL) else {
			throw SWError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let response = response as? HTTPURLResponse,
					(200...399).contains(response.statusCode) else {
			throw SWError.invalidResponse
		}
		
		return try JSONDecoder().decode(PlanetsResponse.self, from: data)
	}
}
