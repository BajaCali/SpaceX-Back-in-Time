import SwiftUI
import Dependencies

extension LaunchDetail {
    @Observable
    final class ViewModel {
        var launch: Launch

        init(launch: Launch) {
            self.launch = launch
        }

        @ObservationIgnored
        @Dependency(EventBroker.self) var eventBroker
    }
}

// MARK: - View Actions

extension LaunchDetail.ViewModel {
    func nextLaunchButtonTapped() {
        eventBroker.post(.detail(.nextLaunchButtonTapped))
    }

    func onDisappear() {
        eventBroker.post(.detail(.dismissing))
    }

    func onAppear() {
        eventBroker.listen(.reusing(via: "LauchDetail"), handleEvents(_:))
    }
}

// MARK: - Functional

extension LaunchDetail.ViewModel {
    private func handleEvents(_ event: Event) {
        switch event {
        case let .detail(.updateLaunchInDetail(launch, hasNext: hasNext, hasPrev: hasPrev)):
            self.launch = launch
            return
        default: return
        }
    }
}
