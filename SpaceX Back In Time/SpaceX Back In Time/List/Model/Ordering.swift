import Foundation

// MARK: - Model

struct Ordering: Codable, Equatable {
    let field: Field
    var direction: Direction
}

// MARK: - Sub-Models

extension Ordering {
    enum Field: String, Codable, Equatable {
        case byName = "name"
        case byFlightNumber = "flight_number"
    }

}

extension Ordering {
    enum Direction: String, Codable, Equatable {
        case ascending
        case descending
    }
}

// MARK: - API Convertible

extension Ordering {
    var apiSorting: [String: String] {
        [field.rawValue: direction.rawValue]
    }
}

// MARK: - Strings

extension Ordering.Field: CustomStringConvertible {
    var description: String {
        switch self {
        case .byName: "Name"
        case .byFlightNumber: "Flight number"
        }
    }
}

extension Ordering.Direction: CustomStringConvertible {
    var description: String {
        rawValue
    }
}

extension Ordering {
    var humanDescription: String {
        return field.description + " " + direction.description
    }
}

// MARK: - Default

extension Ordering {
    static var `default`: Ordering {
        Ordering(field: .byFlightNumber, direction: .descending)
    }
}
