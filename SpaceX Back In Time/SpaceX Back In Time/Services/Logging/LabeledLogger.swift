import Foundation
import Dependencies
import Logging

// MARK: - Class

final class LabeledLoggerDependency<Label> {
    var logger: Logger

    init() {
        self.logger = Self.createLogger(for: Label.self)
    }

    static func createLogger(for labelType: Label.Type) -> Logger {
        var typeString = String(describing: type(of: labelType))
        let typeSuffix = ".Type"
        if typeString.hasSuffix(typeSuffix) {
            typeString.removeLast(typeSuffix.count)
        }
        let label = typeString
        var logger = Logger(label: label)

#if DEBUG
        logger.logLevel = .debug
#endif

        return logger
    }

    func callAsFunction() -> Logger {
        self.logger
    }
}

// MARK: - Dependency

extension LabeledLoggerDependency: DependencyKey {
    static var liveValue: LabeledLoggerDependency<Label> {
        return .init()
    }
}

extension LabeledLoggerDependency: TestDependencyKey {
    static var testValue: LabeledLoggerDependency<Label> {
        .liveValue
    }
}

// MARK: - Property Wrapper

@propertyWrapper
struct LabeledLogger<LabelType> {
    @Dependency(LabeledLoggerDependency<LabelType>.self) var labeledLoggerDependency

    var wrappedValue: Logger {
        labeledLoggerDependency()
    }

    init(for labelType: LabelType.Type) { }
}
