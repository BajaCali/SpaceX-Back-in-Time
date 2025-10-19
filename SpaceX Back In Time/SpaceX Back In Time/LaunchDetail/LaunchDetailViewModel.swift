import SwiftUI
import Dependencies

extension LaunchDetailView {
    @Observable
    final class ViewModel {
        var state: ViewModel.State

        init(_ state: ViewModel.State) {
            self.state = state
        }

        init(launch: Launch, hasNext: Bool, hasPrev: Bool) {
            self.state = .init(launch: launch, hasNext: hasNext, hasPrev: hasPrev)
        }

        @ObservationIgnored
        @Dependency(EventBroker.self) var eventBroker
    }
}

// MARK: - State

extension LaunchDetailView.ViewModel {
    struct State: Equatable {
        var launch: Launch
        var hasNext: Bool
        var hasPrev: Bool

        init(launch: Launch, hasNext: Bool, hasPrev: Bool) {
            self.launch = launch
            self.hasNext = hasNext
            self.hasPrev = hasPrev
        }
    }
}

// MARK: - View Actions

extension LaunchDetailView.ViewModel {
    func nextLaunchButtonTapped() {
        eventBroker.post(.detail(.nextLaunchButtonTapped))
    }

    func prevLaunchButtonTapped() {
        eventBroker.post(.detail(.prevLaunchButtonTapped))
    }

    func onDisappear() {
        eventBroker.post(.detail(.dismissing))
    }

    func onAppear() {
        eventBroker.listen(.reusing(via: "LauchDetail"), handleEvents(_:))
    }
}

// MARK: - Functional

extension LaunchDetailView.ViewModel {
    private func handleEvents(_ event: Event) {
        switch event {
        case let .detail(.updateLaunchInDetail(state)):
            withAnimation {
                self.state = state
            }
            return
        default: return
        }
    }
}
