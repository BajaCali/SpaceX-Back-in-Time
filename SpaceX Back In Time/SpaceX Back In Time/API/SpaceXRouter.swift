import Foundation

// MARK: - Constants

extension SpaceXRouter {
    static let pageLimit: Int = 12
}

// MARK: - Paths

enum SpaceXRouter {
    case launches(page: Int, order: Ordering)
    case launchpad(id: String)
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
        case let .launchpad(id): "launchpads/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .launches: .post
        case .launchpad: .get
        }
    }

    var urlParameters: [(String, Any)]? {
        nil
    }

    var headers: [String: String]? {
        switch self {
        case .launches:
            ["Content-Type": "application/json"]
        case .launchpad: nil
        }
    }

    var body: Data? {
        let body: Any? = switch self {
        case let .launches(page, ordering):
            [
                "options": [
                    "limit": Self.pageLimit,
                    "page": page,
                    "sort": ordering.apiSorting,
                    "select": [
                        "id",
                        "name",
                        "details",
                        "success",
                        "date_unix",
                        "flight_number",
                        "launchpad",
                        "capsules",
                        "payloads",
                        "rocket",
                        "links"
                    ]
                ]
            ]
        case .launchpad: nil
        }

        return body.flatMap { body in
            do {
                return try JSONSerialization.data(withJSONObject: body)
            } catch {
                print("Failed to serialise body with error: \(error)")
                return nil
            }
        }
    }
}
