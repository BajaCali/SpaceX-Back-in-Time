import Foundation
import Combine

final class LiveEventBroker {
    private var lastEvent: PassthroughSubject<Event, Never> = .init()

    private var listeners: Set<AnyCancellable> = .init()

    func post(_ event: Event) {
        lastEvent.send(event)
    }

    func listen(on listener: @escaping (Event) -> Void) {
        lastEvent
            .sink(receiveValue: listener)
            .store(in: &listeners)
    }
}
