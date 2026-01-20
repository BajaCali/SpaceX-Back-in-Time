import SwiftUI

extension LaunchDetailView {
    @Observable
    final class ViewModel {
        var state: State
        var viewController: UIHostingController<LaunchDetailView>?

        var onNextLaunchRequest: (() -> Void)
        var onPrevLaunchRequest: (() -> Void)
        var onDismiss: (() -> Void)

        init(launch: Launch, hasNext: Bool, hasPrev: Bool,
             onNextLaunch: @escaping (() -> Void),
             onPrevLaunch: @escaping (() -> Void),
             onDismiss: @escaping (() -> Void)) {
            self.state = .init(launch: launch, hasNext: hasNext, hasPrev: hasPrev)
            self.onNextLaunchRequest = onNextLaunch
            self.onPrevLaunchRequest = onPrevLaunch
            self.onDismiss = onDismiss
        }
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
        onNextLaunchRequest()
        self.viewController?.title = self.state.launch.title
    }

    func prevLaunchButtonTapped() {
        onPrevLaunchRequest()
        self.viewController?.title = self.state.launch.title
    }

    func onDisappear() {
        onDismiss()
    }
}
