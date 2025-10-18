import SwiftUI
import Dependencies

extension LaunchDetail {
    @Observable
    final class ViewModel {
        var launch: Launch
        var hasNext: Bool
        var hasPrev: Bool

        init(launch: Launch, hasNext: Bool, hasPrev: Bool) {
            self.launch = launch
            self.hasNext = hasNext
            self.hasPrev = hasPrev
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

extension LaunchDetail.ViewModel {
    private func handleEvents(_ event: Event) {
        switch event {
        case let .detail(.updateLaunchInDetail(launch, hasNext: hasNext, hasPrev: hasPrev)):
            withAnimation {
                self.launch = launch
            }
            return
        default: return
        }
    }
}
