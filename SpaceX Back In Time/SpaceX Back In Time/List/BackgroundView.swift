import SwiftUI
import Dependencies

struct LoadingDataView: View {
    var body: some View {
        ProgressView("Waiting for launches to land...")
    }
}

struct ToolbarButton: View {
    let action: () -> Void

    var body: some View {
        Button("TestButton", systemImage: "plus", action: action)
    }
}

struct BackgroundView {
    @State private var state: LaunchesViewController.ViewModel.State

    init(initialState: LaunchesViewController.ViewModel.State) {
        self.state = initialState
    }

    @Dependency(EventBroker.self) var eventBroker

    func onAppear() {
        eventBroker.listen(self.handeEvent(_:))
    }

    func handeEvent(_ event: Event) {
        switch event {
        case let .list(.stateUpdated(newState)):
            self.state = newState
        }
    }
}

extension BackgroundView: View {
    var body: some View {
        Group {
            switch state {
            case .initial, .loaded, .loadingMore:
                EmptyView()
            case .loading:
                ProgressView("Waiting for launches to land...")
            case .networkIssue:
                ContentUnavailableView("Waiting for launches to land...", systemImage: "chevron.down.forward.dotted.2")
            }
        }
        .onAppear(perform: onAppear)
    }
}
