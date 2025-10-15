import Foundation
import Dependencies

struct LaunchesFetcher {
    var getLaunchesPage: (Int) async throws(APIError) -> LaunchesRaw
}

extension LaunchesFetcher: DependencyKey {
    static var liveValue: LaunchesFetcher {
        let apiManager = APIManager()

        return LaunchesFetcher(getLaunchesPage: { (page) throws(APIError) in
            try await apiManager.request(SpaceXRouter.launches(page: page))
        })
    }

    static var previewValue: LaunchesFetcher {
        LaunchesFetcher(
            getLaunchesPage: { _ in
                let decoder = JSONDecoder()
                // swiftlint:disable:next force_try
                return try! decoder.decode(LaunchesRaw.self, from: LaunchesRaw.firstPage)
            }
        )
    }
}
