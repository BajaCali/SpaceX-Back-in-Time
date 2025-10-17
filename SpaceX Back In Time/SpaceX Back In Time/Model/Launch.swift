import Foundation

// MARK: - Struct

struct Launch {
    let title: String
    var isFavourite: Bool
    var date: Date
    var flightNumber: Int
}

// MARK: - Mocks

extension Launch {
    static var mockLaunches: [Launch] {
        return [
            Launch(title: "Falcon 9 - Starlink Mission", isFavourite: true, date: .now, flightNumber: 21)
        ]
    }
}

// MARK: - Raw -> App

extension Launch {
    static func from(raw rawLaunch: LaunchRaw) -> Launch {
        Launch(
            title: rawLaunch.name,
            isFavourite: rawLaunch.success ?? true,
            date: Date(timeIntervalSince1970: TimeInterval(rawLaunch.date_unix)),
            flightNumber: rawLaunch.flight_number,
        )
    }
}
