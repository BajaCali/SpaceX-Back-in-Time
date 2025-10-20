import Foundation

// MARK: - Struct

struct Launch {
    let id: String
    let title: String
    var success: Bool
    var date: Date
    var flightNumber: Int
    var details: String?
    var rocketId: String
    var capsulesIds: [String]
    var payloadsIds: [String]
    var launchpadId: String

    // Links
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let presskitURL: URL?
    let youtubeURL: URL?
    let articleURL: URL?
    let wikipediaURL: URL?
}

extension Launch {
    struct Patch {
        let small: URL?
        let large: URL?
    }

    struct Reddit {
        let campaign: URL?
        let launch: URL?
        let media: URL?
        let recovery: URL?
    }

    struct Flickr {
        let small: [URL]
        let original: [URL]
    }
}

// MARK: - Derived

extension Launch {
    var hasLinks: Bool {
        wikipediaURL != nil
        || articleURL != nil
        || youtubeURL != nil
        || presskitURL != nil
    }

    var hasRedditLinks: Bool {
        reddit?.campaign != nil
        || reddit?.launch != nil
        || reddit?.media != nil
        || reddit?.recovery != nil
    }
}

// MARK: - Fitler

extension Launch {
    func match(by searchText: String) -> Bool {
        Filter(launch: self, searchText: searchText)()
    }
}

// MARK: - Conformances

extension Launch: Equatable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Raw -> App

extension Launch {
    static func from(raw rawLaunch: LaunchRaw) -> Launch {
        let patch = rawLaunch.links.map { links in
            Patch(
                small: links.patch.small.flatMap(URL.init),
                large: links.patch.large.flatMap(URL.init)
            )
        }

        let reddit = rawLaunch.links.map { links in
            Reddit(
                campaign: links.reddit.campaign.flatMap(URL.init),
                launch: links.reddit.launch.flatMap(URL.init),
                media: links.reddit.media.flatMap(URL.init),
                recovery: links.reddit.recovery.flatMap(URL.init)
            )
        }

        let flickr = rawLaunch.links.map { links in
            Flickr(
                small: links.flickr.small.compactMap(URL.init),
                original: links.flickr.original.compactMap(URL.init)
            )
        }

        let presskitURL = rawLaunch.links?.presskit.flatMap(URL.init)
        let youtubeURL = rawLaunch.links?.youtube_id.flatMap { URL(string: "https://www.youtube.com/watch?v=\($0)") }
        let articleURL = rawLaunch.links?.article.flatMap(URL.init)
        let wikipediaURL = rawLaunch.links?.wikipedia.flatMap(URL.init)

        let launch = Launch(
            id: rawLaunch.id,
            title: rawLaunch.name,
            success: rawLaunch.success ?? true,
            date: Date(timeIntervalSince1970: TimeInterval(rawLaunch.date_unix)),
            flightNumber: rawLaunch.flight_number,
            details: rawLaunch.details,
            rocketId: rawLaunch.rocket,
            capsulesIds: rawLaunch.capsules,
            payloadsIds: rawLaunch.payloads,
            launchpadId: rawLaunch.launchpad,
            patch: patch,
            reddit: reddit,
            flickr: flickr,
            presskitURL: presskitURL,
            youtubeURL: youtubeURL,
            articleURL: articleURL,
            wikipediaURL: wikipediaURL
        )

        if launch.flickr?.original.isNotEmpty ?? false {
//            print(launch)
//            dump(launch)
//            debugPrint(launch)
        }

        return launch
    }
}

// MARK: - Mocks

extension Launch {
    static var mockLaunches: [Launch] {
        return [
            Launch(
                id: "Mock",
                title: "Falcon 9 - Starlink Mission",
                success: true,
                date: .now,
                flightNumber: 21,
                details: "Detail of Falcon 9 Starling Mission",
                rocketId: "",
                capsulesIds: [],
                payloadsIds: [],
                launchpadId: "",
                patch: nil,
                reddit: nil,
                flickr: nil,
                presskitURL: nil,
                youtubeURL: nil,
                articleURL: nil,
                wikipediaURL: nil
            )
        ]
    }
}
