import Foundation

enum Event {
    case list(List)
    case background(Background)

    enum List {
        case stateUpdated(LaunchesViewController.ViewModel.State)
    }

    enum Background {
        case tryAgainButtonTapped
    }
}
