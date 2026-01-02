import Foundation

struct ApiOrdering {
    let ordering: Ordering

    init(_ ordering: Ordering) {
        self.ordering = ordering
    }
}

extension ApiOrdering: Encodable {
    func encode(to encoder: any Encoder) throws {
        let ordering = self.ordering

        var container = encoder.unkeyedContainer()
        try container.encode(ordering.field.rawValue)
        try container.encode(ordering.direction.rawValue)
    }
}
