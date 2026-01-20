import Foundation

// MARK: - Model

struct Ordering: Codable, Equatable {
    let field: Field
    let direction: Direction
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

// MARK: - Ordering + AppStorage

extension Ordering: RawRepresentable {
    static let attributesDivider = "-"
    init?(rawValue: String) {
        let parts = rawValue.split(separator: Self.attributesDivider)
        guard parts.count == 2,
              let field = Ordering.Field(rawValue: String(parts[0])),
              let direction = Ordering.Direction(rawValue: String(parts[1]))
        else  {
            return nil
        }

        self.field = field
        self.direction = direction
    }

    var rawValue: String {
        field.rawValue +
        Self.attributesDivider +
        direction.rawValue
    }
}
