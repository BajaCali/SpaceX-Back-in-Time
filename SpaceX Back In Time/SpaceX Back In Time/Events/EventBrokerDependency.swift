import Foundation
import Dependencies

struct EventBroker {
    var post: (Event) -> Void
    var listen: (@escaping (Event) -> Void) -> Void
}

extension EventBroker: DependencyKey {
    public static var liveValue: EventBroker {
        let broker = LiveEventBroker()

        return EventBroker(
            post: broker.post(_:),
            listen: broker.listen(on:)
        )
    }

    public static var previewValue: EventBroker {
        return EventBroker(
            post: { _ in },
            listen: { _ in }
        )
    }
}
