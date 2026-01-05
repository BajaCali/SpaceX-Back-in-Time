import Foundation

enum Event {
    case list(List)
    enum List {
        case stateUpdated(LaunchesViewController.ViewModel.State)
    }

    case background(Background)
    enum Background {
        case tryAgainButtonTapped
    }
}
