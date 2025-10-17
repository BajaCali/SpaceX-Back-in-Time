import Foundation

struct LaunchRaw: Decodable {
    let name: String
    let details: String?
    let success: Bool?
    // swiftlint:disable:next identifier_name
    let date_unix: Int
    // swiftlint:disable:next identifier_name
    let flight_number: Int
    let rocket: String
    let capsules: [String]
    let payloads: [String]
    let launchpad: String
    let links: Links?
}

extension LaunchRaw {
    struct Links: Decodable {
        let patch: PatchLinks
        let reddit: RedditLinks
        let flickr: FlickrLinks
        let presskit: String?
        // swiftlint:disable:next identifier_name
        let youtube_id: String?
        let article: String?
        let wikipedia: String?
    }
}

extension LaunchRaw.Links {
    struct PatchLinks: Codable {
        let small: String?
        let large: String?
    }

    struct RedditLinks: Codable {
        let campaign: String?
        let launch: String?
        let media: String?
        let recovery: String?
    }

    struct FlickrLinks: Codable {
        let small: [String]
        let original: [String]
    }
}
