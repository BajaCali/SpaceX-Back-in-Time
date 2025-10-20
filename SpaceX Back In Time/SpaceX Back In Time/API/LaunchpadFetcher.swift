import Foundation
import Dependencies

struct LaunchpadFetcher {
    var getLaunchpad: (String) async throws(APIError) -> Launchpad
}

extension LaunchpadFetcher: DependencyKey {
    static var liveValue: LaunchpadFetcher {
        let apiManager = APIManager()

        return LaunchpadFetcher(getLaunchpad: { (id) throws(APIError) in
            try await apiManager.request(SpaceXRouter.launchpad(id: id))
        })
    }

    static var previewValue: LaunchpadFetcher {
        LaunchpadFetcher(
            getLaunchpad: { (_) in
                let decoder = JSONDecoder()
                // swiftlint:disable:next force_try
                return try! decoder.decode(Launchpad.self, from: Launchpad.example)
            }
        )
    }
}
