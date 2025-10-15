import Foundation

enum Event {
    case list(List)

    enum List {
        case stateUpdated(LaunchesViewController.ViewModel.State)
    }
}
