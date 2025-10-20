import Foundation
import Combine

final class LiveEventBroker {
    private var lastEvent: PassthroughSubject<Event, Never> = .init()

    private var listeners: [AnyHashable: AnyCancellable] = .init()

    func post(_ event: Event) {
        lastEvent.send(event)
    }

    func listen(id: EventBroker.ListenerId, on listener: @escaping (Event) -> Void) {
        if case let .reusing(via: id) = id, let previous = listeners[id] {
            previous.cancel()
        }

        let id: AnyHashable = switch id {
        case let .reusing(via: customId): customId
        case .singleUse: AnyHashable(UUID())
        }

        let cancellable = lastEvent
            .sink(receiveValue: listener)

        listeners[id] = cancellable
    }
}
