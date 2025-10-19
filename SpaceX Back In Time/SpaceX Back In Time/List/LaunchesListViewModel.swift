import Combine
import Dependencies
import Synchronization

// MARK: - Class

extension LaunchesViewController {
    final class ViewModel {
        @Published var launches: [Launch]
        @Published var searchText: String = "" {
            didSet {
                searchTextUpdated(oldValue: oldValue)
            }
        }
        @Published var state: State = .initial {
            didSet {
                @Dependency(EventBroker.self) var eventBroker
                eventBroker.post(.list(.stateUpdated(state)))
            }
        }
        @Published var errorMessage: String?

        var filteredLaunches: [Launch] {
            guard searchText.isNotEmpty else { return launches }
            return launches.filter { $0.match(by: searchText) }
        }

        private let privateState: Mutex<State> = .init(.initial)
        var totalLaunches: Int?

        @Published var launchInDetail: Launch?
        init() {
            self.launches = .init()
        }

        // MARK: Dependencies

        @Dependency(LaunchesFetcher.self) var launchesFetcher
        @Dependency(EventBroker.self) var eventBroker
    }
}

// MARK: - Functional

extension LaunchesViewController.ViewModel {

    // MARK: Events

    private func handleEvent(_  event: Event) {
        switch event {
        case .list: return

        case .detail(.nextLaunchButtonTapped):
            guard
                let launchInDetail,
                let currentLaunchIndex = launches.firstIndex(of: launchInDetail),
                currentLaunchIndex < (launches.endIndex - 1)
            else {
                return
            }
            sendNewLaunchToDetail(at: launches.index(after: currentLaunchIndex))
            return
        case .detail(.prevLaunchButtonTapped):
            guard
                let launchInDetail,
                let currentLaunchIndex = launches.firstIndex(of: launchInDetail),
                currentLaunchIndex >= 1
            else {
                return
            }
            sendNewLaunchToDetail(at: launches.index(before: currentLaunchIndex))
            return
        case .detail(.dismissing):
            launchInDetail = nil
        case .detail: return

        case .background(.tryAgainButtonTapped):
            fetchAdditionalData()
        }
    }

    // MARK: Fetching

    private func fetchAdditionalData() {
        guard
            privateState().isLoading == false,
            canLoadMore
        else { return }
        updateState(to: filteredLaunches.isEmpty ? .loading : .loadingMore)
        fetchNextPageLaunches()
    }

    private func fetchNextPageLaunches() {
        let nextPage = (launches.count / SpaceXRouter.pageLimit) + 1
        Task(priority: .userInitiated) {
            do {
                let launches: LaunchesRaw = try await launchesFetcher.getLaunchesPage(nextPage)
                dataFetched(.success(launches))
            } catch {
                guard let apiError = error as? APIError else { return }
                dataFetched(.failure(apiError))
            }
        }
    }

    private func dataFetched(_ launchesResult: Result<LaunchesRaw, APIError>) {
        switch launchesResult {
        case let .success(launches):
            self.launches.append(contentsOf: launches.launches)
            self.totalLaunches = launches.totalDocs

            switch (filteredLaunches.isEmpty, canLoadMore) {
                // success - at least one new launch is filtered in (more via rendering row
            case (false, _):
                updateState(to: .loaded)
                // new launches failed to provide search criteria -> dig deeper
            case (true, true):
                fetchNextPageLaunches()
                updateState(to: .loading)
                // cant search more & search failed
            case (true, false):
                // TODO: Introduce new state - no search results
                updateState(to: .noSearchResults(searchText))
            }

        case let .failure(apiError):
            if filteredLaunches.isEmpty {
                updateState(to: .networkIssue(apiError.description))
            } else {
                updateState(to: .loadingMoreFailed)
                errorMessage = apiError.description
            }
        }
    }

    // MARK: Other

    var canLoadMore: Bool {
        let value = totalLaunches.flatMap({ launches.count < $0 }) ?? true

        return value
    }

    private func sendNewLaunchToDetail(at index: Int) {
        let newLaunch = launches[index]
        if let newDetailState = generateDetailState(for: newLaunch) {
            eventBroker.post(.detail(.updateLaunchInDetail(newDetailState)))
            launchInDetail = newLaunch
        }
    }

    private func searchTextUpdated(oldValue: String) {
        switch (oldValue.isEmpty, searchText.isEmpty) {
        case (false, true):
            if privateState.equals(.loadingMore) && filteredLaunches.isEmpty {
                updateState(to: .loading)
            }
        case (_, false):
            if privateState.equals(.loaded) && filteredLaunches.isEmpty {
                if canLoadMore {
                    fetchAdditionalData()
                } else {
                    updateState(to: .noSearchResults(searchText))
                }
            }
        case (true, true): return
        }
    }

    private func updateState(to newState: State) {
        privateState.withLock { $0 = newState }
        state = newState
    }
}

// MARK: - VM -> View

extension LaunchesViewController.ViewModel {
    func generateDetailState(for launch: Launch) -> LaunchDetailView.ViewModel.State? {
        guard let index = launches.firstIndex(of: launch) else { return nil }

        let hasNext = index < (launches.count - 1)
        let hasPrev = index > 0

        return .init(launch: launch, hasNext: hasNext, hasPrev: hasPrev)
    }
}

// MARK: - View Actions

extension LaunchesViewController.ViewModel {
    func onAppear() {
        fetchAdditionalData()
        eventBroker.listen(.singleUse, self.handleEvent(_:))
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

    func detailPushed(with launch: Launch) {
        self.launchInDetail = launch
    }
}
