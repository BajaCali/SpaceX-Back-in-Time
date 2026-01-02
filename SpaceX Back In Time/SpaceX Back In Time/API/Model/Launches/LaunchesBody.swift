import Foundation

struct LaunchesBody {
    var options: Options

    init(page: Int, pageLimit: Int, orderedBy ordering: Ordering) {
        self.options = .init(
            limit: pageLimit,
            page: page,
            sort: [ApiOrdering(ordering)],
            select: SelectField.allCases
        )
    }
}

// MARK: - Options

extension LaunchesBody {
    struct Options: Encodable {
        let limit: Int
        let page: Int
        let sort: [ApiOrdering]
        let select: [LaunchesBody.SelectField]
    }

    enum SelectField: String, CaseIterable, Encodable {
        case id
        case name
        case details
        case success
        case dateUnix = "date_unix"
        case flightNumber = "flight_number"
        case launchpad
        case capsules
        case payloads
        case rocket
        case links
    }
}

// MARK: - Encodable

extension LaunchesBody: Encodable {
}
