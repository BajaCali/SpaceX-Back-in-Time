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

        var launchInDetail: Launch?

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

    // MARK: Other

    private func sendNewLaunchToDetail(at index: Int) {
        let newLaunch = launches[index]
        if let newDetailState = generateDetailState(for: newLaunch) {
            eventBroker.post(.detail(.updateLaunchInDetail(newDetailState)))
            launchInDetail = newLaunch
        }
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
    func testButtonTapped() {
        launches.append(Launch.mockLaunches.randomElement()!)
        showLoadingRow.toggle()
    }

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
