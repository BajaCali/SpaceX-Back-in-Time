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
                self.dataFetched(launches: launches)
            } catch {
                print(error)
            }
        }
    }

    func dataFetched(launches: LaunchesRaw) {
        self.launches = launches.launches
        self.state = .loaded
    }
}

// MARK: - View Actions

extension LaunchesViewController.ViewModel {
    func testButtonTapped() {
        launches.append(Launch.mockLaunches.randomElement()!)
    }

    func launchTapped(_ launch: Launch) {
        print("Tapped on: \(launch.title)")
    }

    func onAppear() {
        state = .loading
        fetchAdditionalData()
    }
}
