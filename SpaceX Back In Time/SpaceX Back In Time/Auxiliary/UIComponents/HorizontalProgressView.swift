import SwiftUI

struct HorizontalProgressView: View {
    @State private var startDate = Date.now

    var body: some View {
        TimelineView(.animation) { timeline in
            let elapsedTime = startDate.distance(to: timeline.date)
            let progress = getProgress(elapsedTime)

            ProgressView(value: progress)
                .padding(.horizontal, 150)
        }
    }

    func getProgress(_ timeElapsed: TimeInterval) -> Double {
        let time = 1.3 * timeElapsed
        return if Int(time) % 2 == 0 {
            (1 - fmod(Double(time), 1))
        } else {
            fmod(Double(time), 1)
        }
    }
}
