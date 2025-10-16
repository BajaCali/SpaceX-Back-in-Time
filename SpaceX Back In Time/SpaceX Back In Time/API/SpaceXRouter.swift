import Foundation

// MARK: - Constants

extension SpaceXRouter {
    static let pageLimit: Int = 12
}

// MARK: - paths

enum SpaceXRouter {
    case launches(page: Int)
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

    var headers: [String: String]? {
        switch self {
        case .launches:
            ["Content-Type": "application/json"]
        }
    }

    var body: Data? {
        let body: Any = switch self {
        case let .launches(page):
            [
                "options": [
                    "limit": Self.pageLimit,
                    "page": page
                ]
            ]
        }

        do {
            return try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Failed to serialise body with error: \(error)")
            return nil
        }
    }
}
