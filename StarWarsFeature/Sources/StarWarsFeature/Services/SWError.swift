import Foundation

public enum SWError: Error {
	case invalidURL
	case invalidResponse
	case message(String)
}

extension SWError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .invalidResponse:
			return "Invalid Response"
		case .message(let message):
			return message
		}
	}
}
