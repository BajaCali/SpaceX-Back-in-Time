import Foundation

struct LaunchesRaw: Decodable {
    var docs: [LaunchRaw]
    var totalDocs: Int
}

// MARK: - Raw -> App

extension LaunchesRaw {
    var launches: [Launch] {
        self.docs.map(Launch.from(raw:))
    }
}
