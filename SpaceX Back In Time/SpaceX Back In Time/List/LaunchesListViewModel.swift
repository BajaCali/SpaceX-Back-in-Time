import Combine
import Dependencies

extension LaunchesViewController {
    final class ViewModel {
        @Published var launches: [Launch]
        @Published var state: State {
            didSet {
                @Dependency(EventBroker.self) var eventBroker
                eventBroker.post(.list(.stateUpdated(state)))
            }
        }
        @Published var errorMessage: String?
        @Published var showLoadingRow: Bool

        var pageInLoad: Int?
        var pagesAvailable: Int?

        init() {
            self.launches = .init()
            self.state = .initial
            self.showLoadingRow = false
        }

        @Dependency(LaunchesFetcher.self) var launchesFetcher
    }
}

// MARK: - Functional

extension LaunchesViewController.ViewModel {
    private func fetchAdditionalData() {
        guard state.isLoading == false else { return }
        if launches.isNotEmpty {
            showLoadingRow = true
        }
        let nextPage = {
            (launches.count / SpaceXRouter.pageLimit) + 1
        }()
        state = .loading
        fetchLaunches(page: nextPage)
    }

    private func fetchLaunches(page: Int) {
        Task(priority: .userInitiated) {
            do {
                let launches: LaunchesRaw = try await launchesFetcher.getLaunchesPage(page)
//                let launches: LaunchesRaw = try await LaunchesFetcher.previewValue.getLaunchesPage(1)
                dataFetched(.success(launches))
            } catch {
                guard let apiError = error as? APIError else { return }
                dataFetched(.failure(apiError))
            }
        }
    }

    private func dataFetched(_ launchesResult: Result<LaunchesRaw, APIError>) {
        self.showLoadingRow = false
        switch launchesResult {
        case let .success(launches):
            self.launches.append(contentsOf: launches.launches)
            self.state = .loaded

        case let .failure(apiError):
            state = .networkIssue
            errorMessage = apiError.description
        }
    }
}

// MARK: - View Actions

extension LaunchesViewController.ViewModel {
    func testButtonTapped() {
        launches.append(Launch.mockLaunches.randomElement()!)
        showLoadingRow.toggle()
    }

    func launchTapped(_ launch: Launch) {
        print("Tapped on: \(launch.title)")
    }

    func onAppear() {
        fetchAdditionalData()
    }

    func errorOkButtonTapped() {
        state = .networkIssue
    }

    func errorTryAgainButtonTapped() {
        fetchAdditionalData()
    }

    func rendering(row: Int) {
        let isNearBottom = row >= (launches.count - 2)
        if isNearBottom {
            fetchAdditionalData()
        }
    }
}
