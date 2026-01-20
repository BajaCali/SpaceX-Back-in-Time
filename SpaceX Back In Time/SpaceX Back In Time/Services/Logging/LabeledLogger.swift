import Foundation
import Logging

// MARK: - Class

private final class LabeledLoggerImpl<Label> {
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

// MARK: - Property Wrapper

@propertyWrapper
struct LabeledLogger<LabelType> {
    private let labeledLogger: LabeledLoggerImpl<LabelType>

    var wrappedValue: Logger {
        labeledLogger.logger
    }

    init(for labelType: LabelType.Type) {
        self.labeledLogger = .init()
    }
}
