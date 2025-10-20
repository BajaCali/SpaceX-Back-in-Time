import Foundation

final class APIManager {
    private lazy var urlSession: URLSession = {
#if targetEnvironment(simulator)
        let config = URLSessionConfiguration.ephemeral
#else
        let config = URLSessionConfiguration.default
#endif
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10

        return URLSession(configuration: config)
    }()

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    private func fetch(_ request: URLRequest) async throws(APIError) -> (Data, URLResponse) {
        do {
            return try await urlSession.data(for: request)
        } catch {
            throw .requestError(error)
        }
    }

    private func request(_ endpoint: Endpoint) async throws(APIError) -> Data {
        let request: URLRequest = try endpoint.asRequest()

        let (data, response) = try await fetch(request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unacceptableResponseStatusCode
        }

        return data
    }
}

// MARK: - Conformances

extension APIManager: APIManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws(APIError) -> T {
        let data = try await request(endpoint)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            throw .decodingError(error)
        }
    }
}
