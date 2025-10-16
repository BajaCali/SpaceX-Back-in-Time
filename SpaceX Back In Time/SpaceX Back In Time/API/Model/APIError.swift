import Foundation

enum APIError: Error {
    case invalidUrlComponents
    case noResponse
    case unacceptableResponseStatusCode
    case customDecodingFailed
    case malformedUrl
    case requestError(Error)
    case decodingError(Error)
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidUrlComponents:
            return "Server connection details are missing or invalid."
        case .noResponse:
            return "The server sent an empty response."
        case .unacceptableResponseStatusCode:
            return "The server reported an error (4xx or 5xx)."
        case .customDecodingFailed:
            return "Couldn't understand the data received from the server."
        case .malformedUrl:
            return "Internal URL format error."
        case .requestError(let error):
            return "Network connection failed. (\(error.localizedDescription))"
        case .decodingError:
            return "Failed to process server data."
        }
    }
}
