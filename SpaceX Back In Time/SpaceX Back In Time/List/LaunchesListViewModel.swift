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
            self.launches = [Launch.mockLaunches[0]]
            self.state = .initial
        }

    }
}

// MARK: - View Actions

extension LaunchesViewController.ViewModel {
    func testButtonTapped() {
        launches.append(Launch.mockLaunches.randomElement()!)
        self.state = .loaded
    }

    func launchTapped(_ launch: Launch) {
        print("Tapped on: \(launch.title)")
    }

    func onAppear() {
        state = .loading
    }
}
