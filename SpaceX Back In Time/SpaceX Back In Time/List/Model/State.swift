import Foundation

extension LaunchesViewController.ViewModel {
    enum State {
        case initial
        case loading
        case loadingMore
        case networkIssue
        case loaded
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
