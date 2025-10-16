import SwiftUI
import Dependencies

// MARK: - Constants

extension BackgroundView {
    enum Constants {
        static let contentUnAvailableHeight: CGFloat = 140
    }
}

struct BackgroundView {
    @State private var state: LaunchesViewController.ViewModel.State
    @State private var startDate = Date.now
    @State private var startAnimation = false

    init(initialState: LaunchesViewController.ViewModel.State) {
        self.state = initialState
    }

    @Dependency(EventBroker.self) var eventBroker

    func onAppear() {
        eventBroker.listen(self.handleEvent(_:))
        startAnimation.toggle()
    }

    func handleEvent(_ event: Event) {
        switch event {
        case let .list(.stateUpdated(newState)):
            self.state = newState
        default: return
        }
    }
}

extension BackgroundView: View {
    var body: some View {
        content
            .onAppear(perform: onAppear)
    }

    @ViewBuilder
    var content: some View {
        switch state {
        case .initial, .loaded, .loadingMore, .loadingMoreFailed:
            EmptyView()
        case .loading:
            loadingView
        case let .networkIssue(issue):
            networkErrorView(errorDescription: issue)
        }
    }

    func networkErrorView(errorDescription: String) -> some View {
        VStack {
            ContentUnavailableView {
                Label("Network issue", systemImage: "wifi.exclamationmark")
                    .symbolEffect(.wiggle.clockwise.byLayer, options: .repeat(.continuous).speed(0.7))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.primary, .primary)
            } description: {
                Text(errorDescription)
            } actions: {
                Button("Try Again", systemImage: "repeat") {
                    eventBroker.post(.background(.tryAgainButtonTapped))
                }
                .buttonStyle(.bordered)
                .labelStyle(.titleAndIcon)
            }
        }
    }

    var loadingView: some View {
        VStack {
            ContentUnavailableView(
                "Waiting for launches to land...",
                systemImage: "chevron.down.forward.dotted.2"
            )
            .symbolEffect(.bounce, options: .repeat(.continuous).speed(0.1))
            .symbolEffect(.wiggle, options: .repeat(.continuous).speed(0.5))
            .symbolEffect(.pulse, options: .repeat(.continuous))
            .frame(height: Constants.contentUnAvailableHeight)

            horizontalProgressView
        }
    }

    var horizontalProgressView: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startDate.distance(to: timeline.date)
            let progress = getProgress(elapsedTime)

        ProgressView(value: progress)
                .padding(.horizontal, 150)
        }
    }

    func getProgress(_ timeElapsed: TimeInterval) -> Double {
        let time = 1.3 * timeElapsed
        return if Int(time) % 2 == 0 {
            (1 - fmod(Double(time), 1))
        } else {
            fmod(Double(time), 1)
        }
    }
}

#Preview("Loading") {
    BackgroundView(initialState: .loading)
}

#Preview("Network error") {
    BackgroundView(initialState: .networkIssue("Yeah, an networking error happened..."))
}

#Preview("Aless gut") {
    BackgroundView(initialState: .loaded)
}
