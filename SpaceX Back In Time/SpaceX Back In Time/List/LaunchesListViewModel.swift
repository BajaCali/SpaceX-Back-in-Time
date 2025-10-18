import Combine
import Dependencies

// MARK: - Class

extension LaunchesViewController {
    final class ViewModel {
        @Published var launches: [Launch]
        @Published var searchText: String = ""
        @Published var state: State {
            didSet {
                @Dependency(EventBroker.self) var eventBroker
                eventBroker.post(.list(.stateUpdated(state)))
            }
        }
        @Published var errorMessage: String?
        @Published var showLoadingRow: Bool

        var filteredLaunches: [Launch] {
            if searchText.isEmpty {
                return launches
            } else {
                return launches.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

        var pageInLoad: Int?
        var pagesAvailable: Int?

        init() {
            self.launches = .init()
            self.state = .initial
            self.showLoadingRow = false
        }

        // MARK: Dependencies

        @Dependency(LaunchesFetcher.self) var launchesFetcher
        @Dependency(EventBroker.self) var eventBroker
    }
}

// MARK: - Functional

extension LaunchesViewController.ViewModel {
    private func handleEvent(_  event: Event) {
        switch event {
        case .list: return
        case .background(.tryAgainButtonTapped):
            fetchAdditionalData()
        }
    }

    private func fetchAdditionalData() {
        guard state.isLoading == false else { return }
        if launches.isNotEmpty {
            showLoadingRow = true
        }
        let nextPage = {
            (launches.count / SpaceXRouter.pageLimit) + 1
        }()
        state = launches.isEmpty ? .loading : .loadingMore
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
            if launches.isEmpty {
                state = .networkIssue(apiError.description)
            } else {
                state = .loadingMoreFailed
                errorMessage = apiError.description
            }
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
        eventBroker.listen(self.handleEvent(_:))
    }

    func errorOkButtonTapped() {

    }

    func errorTryAgainButtonTapped() {
        fetchAdditionalData()
    }

    func rendering(row: Int) {
        guard searchText.isEmpty else { return }
        let isNearBottom = row >= (filteredLaunches.count - 2)
        if isNearBottom {
            fetchAdditionalData()
        }
    }
}
