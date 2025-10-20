import Foundation

struct Launchpad: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let fullName: String
    let status: String
    let type: String?
    let locality: String
    let region: String
    let latitude: Double
    let longitude: Double
//    let landingAttempts: Int
//    let landingSuccesses: Int
    let wikipedia: String?
    let details: String
    let launches: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, status, type, locality, region, latitude, longitude, wikipedia, details, launches
        case fullName = "full_name"
//        case landingAttempts = "landing_attempts"
//        case landingSuccesses = "landing_successes"
    }
}
