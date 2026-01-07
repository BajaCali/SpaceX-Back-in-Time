import Foundation
import Combine

/// Watch updates on multiple places while updating inner value from one place.
///
/// Observable class to watch for updates of value. The creator of an instance gets the only access to change value
/// via Controller closure. Make sure to store the closure & use weak self to further transform the state and avoid
/// retain cycles.
@Observable
@MainActor
final class SingleWriterMultipleReaderStore<Value> {
    typealias Controller = (@Sendable (inout Value) -> Void) -> Void

    private(set) var state: Value

    @ObservationIgnored
    private let stateSubject = PassthroughSubject<Value, Never>()

    var publisher: AnyPublisher<Value, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // Provide a controller at init time to the callee
    init(_ initialState: Value, configure: (@escaping Controller) -> Void) {
        self.state = initialState
        let controller: Controller = { [weak self] transform in
            guard let self else { return }
            var copy = self.state
            transform(&copy)
            self.state = copy
            self.stateSubject.send(copy)
        }
        configure(controller)
    }
}
