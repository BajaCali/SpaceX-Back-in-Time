import Foundation

// MARK: - Protocol

protocol Endpoint {
    static var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlParameters: [(String, Any)]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

    func asRequest() throws(APIError) -> URLRequest
}

// MARK: - default implementation of converting to request

extension Endpoint {
    func asRequest() throws(APIError) -> URLRequest {
        let urlPath = Self.baseUrl.appendingPathComponent(path)

        guard var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: true) else {
            throw APIError.invalidUrlComponents
        }

        if let urlParameters = urlParameters {
            urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        }

        guard let requestUrl = urlComponents.url else {
            throw APIError.invalidUrlComponents
        }

        var request = URLRequest(url: requestUrl)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body

        return request
    }
}
