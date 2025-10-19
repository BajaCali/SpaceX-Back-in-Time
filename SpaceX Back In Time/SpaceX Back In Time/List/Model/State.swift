import Foundation

extension LaunchesViewController.ViewModel {
    enum State: Equatable {
        case initial
        case loading
        case loadingMore
        case networkIssue(String)
        case loadingMoreFailed
        case loaded
        case noSearchResults(String)
    }
}

extension LaunchesViewController.ViewModel.State {
    var isLoading: Bool {
        switch self {
        case .loading, .loadingMore: true
        default: false
        }
    }
}
