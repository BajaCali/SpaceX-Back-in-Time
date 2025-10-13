import Foundation

struct Launch {
    let title: String
    var isFavourite: Bool
}

// MARK: - Mocks

extension Launch {
    static var mockLaunches: [Launch] {
        return [
            Launch(title: "Falcon 9 - Starlink Mission", isFavourite: true),
            Launch(title: "Atlas V - GOES-T", isFavourite: false),
            Launch(title: "Artemis I - Orion Spacecraft", isFavourite: true),
            Launch(title: "Soyuz MS-22", isFavourite: false),
            Launch(title: "Long March 5B - Wentian", isFavourite: false),
            Launch(title: "Vega-C - LARES 2", isFavourite: true)
        ]
    }
}
