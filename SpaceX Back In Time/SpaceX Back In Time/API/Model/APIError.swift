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
