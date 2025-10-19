import Combine
import Dependencies
import Synchronization

// MARK: - Class

extension LaunchesViewController {
    final class ViewModel {
        @Published var launches: [Launch]
        @Published var searchText: String = ""
        @Published var state: State {
            didSet {
                @Dependency(EventBroker.self) var eventBroker
                eventBroker.post(.list(.stateUpdated(state)))

                isLoading.withLock { $0 = state.isLoading }
            }
        }
        @Published var errorMessage: String?
        @Published var showLoadingRow: Bool

        var filteredLaunches: [Launch] {
            guard searchText.isNotEmpty else { return launches }
            return launches.filter { $0.match(by: searchText) }
        }

        let isLoading: Mutex<Bool> = .init(false)

        var totalLaunches: Int?
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
        guard
            isLoading.withLock({ return $0 == false }),
            totalLaunches.flatMap({ launches.count < $0 }) ?? true
        else { return }
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
            self.totalLaunches = launches.totalDocs

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
        let isNearBottom = row >= (filteredLaunches.count - 2)
        if isNearBottom {
            fetchAdditionalData()
        }
    }
}
