import Foundation
import Combine
import Dependencies
import Logging
import Synchronization
import Sharing
import SwiftUI

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

        @Published var detailViewModel: LaunchDetailView.ViewModel?

        @Shared(.appStorage("launchesOrdering")) var ordering: Ordering = .default

        @LabeledLogger(for: LaunchesViewController.ViewModel.self) var logger

        init() {
            self.launches = .init()
        }

        // MARK: Dependencies

        @Dependency(LaunchesFetcher.self) var launchesFetcher
    }
}

// MARK: - Functional

extension LaunchesViewController.ViewModel {

    // MARK: Detail View Callbacks

    private func advanceToNextLaunch() {
        guard
            let currentDetailLaunch = detailViewModel?.state.launch,
            let currentLaunchIndex = launches.firstIndex(of: currentDetailLaunch),
            currentLaunchIndex < (launches.endIndex - 1)
        else {
            return
        }
        // Directly update the state of the existing detailViewModel instance
        updateDetailViewModel(at: launches.index(after: currentLaunchIndex))
    }

    private func goBackToPreviousLaunch() {
        guard
            let currentDetailLaunch = detailViewModel?.state.launch,
            let currentLaunchIndex = launches.firstIndex(of: currentDetailLaunch),
            currentLaunchIndex >= 1
        else {
            return
        }
        // Directly update the state of the existing detailViewModel instance
        updateDetailViewModel(at: launches.index(before: currentLaunchIndex))
    }

    private func dismissDetailView() {
        detailViewModel = nil
    }


    // MARK: Detail Creation

    func makeDetailViewModel(for launch: Launch) -> LaunchDetailView.ViewModel? {
        guard let detailState = self.generateDetailState(for: launch) else { return nil }

        let viewModel = LaunchDetailView.ViewModel(
            launch: detailState.launch,
            hasNext: detailState.hasNext,
            hasPrev: detailState.hasPrev,
            onNextLaunch: { [weak self] in
                self?.advanceToNextLaunch()
            },
            onPrevLaunch: { [weak self] in
                self?.goBackToPreviousLaunch()
            },
            onDismiss: { [weak self] in
                self?.dismissDetailView()
            }
        )

        self.detailViewModel = viewModel

        return viewModel
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
            do throws(APIError) {
                let launchesRaw: LaunchesRaw = try await launchesFetcher
                    .getLaunchesPage(nextPage, ordering)
                dataFetched(.success(launchesRaw))
            } catch {
                logger.error("Failed to fetch launches: \(error)")
                dataFetched(.failure(error))
            }
        }
    }

    private func dataFetched(_ launchesResult: Result<LaunchesRaw, APIError>) {
        switch launchesResult {
        case let .success(rawLaunches):
            let newLaunches = rawLaunches.launches
            self.launches.append(contentsOf: newLaunches)
            self.totalLaunches = rawLaunches.totalDocs

            switch (filteredLaunches.isEmpty, canLoadMore) {
            case (false, _):
                updateState(to: .loaded)
            case (true, true):
                fetchNextPageLaunches()
                updateState(to: .loading)
            case (true, false):
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

    private func reloadAllData() {
        self.launches.removeAll()
        fetchAdditionalData()
    }

    // MARK: Other

    var canLoadMore: Bool {
        let value = totalLaunches.flatMap({ launches.count < $0 }) ?? true

        return value
    }

    private func updateDetailViewModel(at index: Int) {
        let newLaunch = launches[index]
        if let newDetailState = generateDetailState(for: newLaunch) {
            withAnimation {
                detailViewModel?.state = newDetailState
            }
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

    private func adjustURLCacheForImages() {
        URLCache.shared.memoryCapacity = 50_000_000
        URLCache.shared.diskCapacity = 500_000_000
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
        adjustURLCacheForImages()
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


    func tappedButtonToChangeOrdering(to newOrdering: Ordering) {
        self.$ordering.withLock { $0 = newOrdering }
        reloadAllData()
    }
}
