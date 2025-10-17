import Foundation

// MARK: - Struct

struct Launch {
    let title: String
    var success: Bool
    var date: Date
    var flightNumber: Int
    var details: String?
    var rocketId: String
    var capsulesIds: [String]
    var payloadsIds: [String]
    var launchpadId: String
}

// MARK: - Fitler

extension Launch {
    func match(by searchText: String) -> Bool {
        Filter(launch: self, searchText: searchText)()
    }
}

// MARK: - Mocks

extension Launch {
    static var mockLaunches: [Launch] {
        return [
            Launch(
                title: "Falcon 9 - Starlink Mission",
                success: true,
                date: .now,
                flightNumber: 21,
                details: "Detail of Falcon 9 Starling Mission",
                rocketId: "",
                capsulesIds: [],
                payloadsIds: [],
                launchpadId: ""
            )
        ]
    }
}

// MARK: - Raw -> App

extension Launch {
    static func from(raw rawLaunch: LaunchRaw) -> Launch {
        print(rawLaunch.name, "has details:", rawLaunch.details != nil)
        return Launch(
            title: rawLaunch.name,
            success: rawLaunch.success ?? true,
            date: Date(timeIntervalSince1970: TimeInterval(rawLaunch.date_unix)),
            flightNumber: rawLaunch.flight_number,
            details: rawLaunch.details,
            rocketId: rawLaunch.rocket,
            capsulesIds: rawLaunch.capsules,
            payloadsIds: rawLaunch.payloads,
            launchpadId: rawLaunch.launchpad
        )
    }
}
