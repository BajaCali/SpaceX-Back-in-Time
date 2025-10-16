import Combine
import Dependencies

extension LaunchesViewController.ViewModel {
    enum State {
        case initial
        case loading
        case networkIssue
        case loaded
    }
}

extension LaunchesViewController {
    final class ViewModel {
        @Published var launches: [Launch]
        @Published var state: State = .initial {
            didSet {
                @Dependency(EventBroker.self) var eventBroker
                eventBroker.post(.list(.stateUpdated(state)))
            }
        }
        @Published var errorMessage: String?

        init() {
            self.launches = .init()
            self.state = .initial
        }

        @Dependency(LaunchesFetcher.self) var launchesFetcher
    }
}

// MARK: - Functional

extension LaunchesViewController.ViewModel {
    func fetchAdditionalData() {
        Task(priority: .userInitiated) {
            do {
                let launches: LaunchesRaw = try await launchesFetcher.getLaunchesPage(0)
//                let launches: LaunchesRaw = try await LaunchesFetcher.previewValue.getLaunchesPage(0)
                dataFetched(.success(launches))
            } catch {
                guard let apiError = error as? APIError else { return }
                dataFetched(.failure(apiError))
            }
        }
    }

    func dataFetched(_ launchesResult: Result<LaunchesRaw, APIError>) {
        switch launchesResult {
        case let .success(launches):
            self.launches = launches.launches
            self.state = .loaded
        case let .failure(apiError):
            errorMessage = apiError.description
        }
    }
}

// MARK: - View Actions

extension LaunchesViewController.ViewModel {
    func testButtonTapped() {
        errorMessage = "An test error happend!"
        launches.append(Launch.mockLaunches.randomElement()!)
    }

    func launchTapped(_ launch: Launch) {
        print("Tapped on: \(launch.title)")
    }

    func onAppear() {
        state = .loading
        fetchAdditionalData()
    }

    func errorOkButtonTapped() {
        state = .networkIssue
    }

    func errorTryAgainButtonTapped() {
        fetchAdditionalData()
        state = .loading
    }
}
