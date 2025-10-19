import SwiftUI

// MARK: - Constants

extension HorizontalProgressView {
    enum Constants {
        static let defaultSpeed: Double = 1.3
        static let defaultWidth: CGFloat = 100
    }
}

// MARK: - Struct

struct HorizontalProgressView: View {
    let speed: Double
    let width: CGFloat

    @State private var startDate = Date.now

    init(speed: Double? = nil, width: CGFloat? = nil) {
        self.speed = speed ?? Constants.defaultSpeed
        self.width = width ?? Constants.defaultWidth
        self.startDate = startDate
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startDate.distance(to: timeline.date)
            let progress = getProgress(elapsedTime)

            ProgressView(value: progress)
                .frame(width: width)
        }
    }

    func getProgress(_ timeElapsed: TimeInterval) -> Double {
        let time = speed * timeElapsed
        return if Int(time) % 2 == 0 {
            (1 - fmod(Double(time), 1))
        } else {
            fmod(Double(time), 1)
        }
    }
}
