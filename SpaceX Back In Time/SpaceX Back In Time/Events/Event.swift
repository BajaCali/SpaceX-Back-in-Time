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

    case detail(Detail)
    enum Detail {
        case dismissing
        case nextLaunchButtonTapped
        case prevLaunchButtonTapped
        case updateLaunchInDetail(Launch, hasNext: Bool, hasPrev: Bool)
    }
}
