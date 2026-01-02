import Foundation

// MARK: - Constants

extension SpaceXRouter {
    static let pageLimit: Int = 12
}

// MARK: - Paths

enum SpaceXRouter {
    case launches(page: Int, order: Ordering)
}

// MARK: - Support

extension SpaceXRouter {
    static var dataBodyEncoder: JSONEncoder = {
        JSONEncoder()
    }()
}

// MARK: - Endpoint properties

extension SpaceXRouter: Endpoint {
    static var baseUrl: URL {
        URL(string: "https://api.spacexdata.com/v4/")!
    }

    var path: String {
        switch self {
        case .launches: "launches/query"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .launches: .post
        }
    }

    var urlParameters: [(String, Any)]? {
        nil
    }

    var headers: [Header]? {
        switch self {
        case .launches:
            [.contentType(.applicationJson)]
        }
    }

    var body: Data? {
        let body: Encodable = switch self {
        case let .launches(page, ordering):
            LaunchesBody(page: page, pageLimit: Self.pageLimit, orderedBy: ordering)
        }

        do {
            return try JSONEncoder().encode(body)
        } catch {
            print("Failed to serialise body with error: \(error)")
            return nil
        }
    }
}
