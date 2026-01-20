import Foundation

// MARK: - Header

enum Header {
   case contentType(ContentType)
}

// MARK: - HTTP Support

extension Header {
    var name: String {
        switch self {
        case .contentType: "Content-Type"
        }
    }

    var value: String {
        switch self {
        case .contentType(let contentType): contentType.rawValue
        }
    }

    var flatten: (String, String) {
        (name, value)
    }
}

// MARK: - Header Types

extension Header {
    enum ContentType: String {
        case applicationJson = "application/json"
    }
}

