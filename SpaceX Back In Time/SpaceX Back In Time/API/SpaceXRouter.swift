import Foundation

// MARK: - Constants

extension SpaceXRouter {
}

// MARK: - paths

enum SpaceXRouter {
    case launches(page: Int)
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
        nil
    }

    var body: Data? {
        return Data()
    }
}
