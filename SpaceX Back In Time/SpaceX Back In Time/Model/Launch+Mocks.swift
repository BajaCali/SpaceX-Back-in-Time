// swiftlint:disable all

import Foundation

#if DEBUG
extension Launch {
    static var withImages: Launch {
        Launch(
            id: "CSG-2",
            title: "CSG-2",
            success: true,
            date: .now,
            flightNumber: 147,
            details: "Falcon 9 launches to sun-synchronous polar orbit from Florida as part of CSG-2 Mission. The mission lifts off from SLC-40, Cape Canaveral on a southward azimuth and performs a dogleg maneuver. The booster for this mission is expected to return to LZ-1 based on FCC communications filings",
            rocketId: "5e9d0d95eda69973a809d1ec",
            capsulesIds: [],
            payloadsIds: ["6161d3a06db1a92bfba8535a"],
            launchpadId: "5e9e4501f509094ba4566f84",
            patch: Patch(
              small: URL(string: "https://images2.imgbox.com/69/be/Y0sIjJ6f_o.png")!,
              large: URL(string: "https://images2.imgbox.com/ea/26/DjPDzbZl_o.png")
            ),
            reddit: Reddit(
              campaign: URL(string: "https://www.reddit.com/r/spacex/comments/sarr7x/rspacex_csg2_campaign_thread/"),
              launch: URL(string: "https://www.reddit.com/r/spacex/comments/sdtz77/rspacex_csg2_launch_discussion_and_updates_thread/")!,
              media: nil,
              recovery: nil
            ),
            flickr: Flickr(
              small: [],
              original: [
                URL(string: "https://live.staticflickr.com/65535/51856205295_4ec1c21ce3_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51854587612_b30f28ede1_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51855875789_b27465e1f2_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51855546836_710848417a_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51855627363_c927574ce4_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51854587577_cfe014f0e9_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51855875759_a4cdc29fbf_o.jpg")!,
                URL(string: "https://live.staticflickr.com/65535/51855546821_7900aed52d_o.jpg")!
              ]
            ),
            presskitURL: nil,
            youtubeURL: URL(string: "https://www.youtube.com/watch?v=AbFoi68L-GQ")!,
            articleURL: URL(string: "https://spaceflightnow.com/2022/02/01/italian-radar-satellite-rides-spacex-rocket-into-polar-orbit/")!,
            wikipediaURL: nil)
    }
}
#endif

// swiftlint:enable all
