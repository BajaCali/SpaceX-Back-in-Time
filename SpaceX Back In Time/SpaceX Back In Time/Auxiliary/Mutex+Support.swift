import Synchronization

extension Mutex where Value: Equatable {
    func equals(_ other: Value) -> Bool {
        self.withLock { other == $0 }
    }
}

extension Mutex where Value: Copyable {
    func callAsFunction() -> Value {
        self.withLock { return $0 }
    }
}
