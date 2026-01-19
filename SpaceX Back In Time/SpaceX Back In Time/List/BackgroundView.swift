import SwiftUI

// MARK: - Constants

extension BackgroundView {
    enum Constants {
        static let contentUnAvailableHeight: CGFloat = 140
    }
}

struct BackgroundView {
    @State private var stateStore: LaunchesViewController.ViewModel.StateStore
    let onTryAgainButtonTap: () -> Void

    init(
        stateStore: LaunchesViewController.ViewModel.StateStore,
        onTryAgainButtonTap: @escaping () -> Void
    ) {
        self.stateStore = stateStore
        self.onTryAgainButtonTap = onTryAgainButtonTap
    }
}

// MARK: - View

extension BackgroundView: View {
    var body: some View {
        switch stateStore.state {
        case .initial, .loaded, .loadingMore, .loadingMoreFailed:
            EmptyView()
        case .loading:
            loadingView
        case let .networkIssue(issue):
            networkErrorView(errorDescription: issue)
        case let .noSearchResults(searchText):
            noSearchResults(searchText)
        }
    }

    func noSearchResults(_ searchText: String) -> some View {
        ContentUnavailableView(
            "No Launches found.",
            systemImage: "magnifyingglass",
            description: Text("No results found for\"\(searchText)\"")
        )
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
                Button("Try Again", systemImage: "repeat", action: onTryAgainButtonTap)                .buttonStyle(.bordered)
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

            HorizontalProgressView()
        }
    }
}

// MARK: - Previews

#if DEBUG

extension LaunchesViewController.ViewModel.StateStore {
    convenience init(_ state: LaunchesViewController.ViewModel.State) {
        self.init(state, configure: { _ in })
    }
}

#Preview("Loading") {
    BackgroundView(stateStore: .init(.loading), onTryAgainButtonTap: { })
}

#Preview("Network error") {
    BackgroundView(stateStore: .init(.networkIssue("Yeah, an networking error happened...")), onTryAgainButtonTap: { })
}

#Preview("Aless gut") {
    BackgroundView(stateStore: .init(.loaded), onTryAgainButtonTap: { })
}

#endif // DEBUG

