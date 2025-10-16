import Foundation

struct LaunchRaw: Decodable {
    var name: String
    var detail: String?
    var success: Bool?
    // swiftlint:disable:next identifier_name
    var date_unix: Int
    // swiftlint:disable:next identifier_name
    var flight_number: Int
}
