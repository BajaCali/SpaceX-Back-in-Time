import Foundation

extension EventBroker {
    enum ListenerId {
        /// Use when the listener is active for the whole length of app live cycle.
        ///
        /// Listening does not get cancelled.
        case singleUse
        /// Use this form for callees that are being reused.
        ///
        /// When `listen` is called again with the same id, the last listening gets cancelled.
        case reusing(via: AnyHashable)
    }
}
