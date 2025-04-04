import Foundation

extension SWService {
	public static let live = SWService {
		guard let url = URL(string: Constants.baseURL)?.appending(path: Endpoint.planets.rawValue) else {
			throw SWError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let response = response as? HTTPURLResponse,
					(200...399).contains(response.statusCode) else {
			throw SWError.invalidResponse
		}
		
		return try JSONDecoder().decode(SWPlanetsResponse.self, from: data)
	} fetchPeople: {
		guard let url = URL(string: Constants.baseURL)?.appending(path: Endpoint.people.rawValue) else {
			throw SWError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let response = response as? HTTPURLResponse,
					(200...399).contains(response.statusCode) else {
			throw SWError.invalidResponse
		}
		
		return try JSONDecoder().decode(SWPeopleResponse.self, from: data)
	}
}
