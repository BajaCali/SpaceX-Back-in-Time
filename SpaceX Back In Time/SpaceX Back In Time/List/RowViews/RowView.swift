import SwiftUI

struct RowView: View {
    let launch: Launch

    var singleLineText: String {
        return if launch.success {
            "⭐️ \(launch.title)"
        } else {
            launch.title
        }
    }

    var body: some View {
        Text(singleLineText)
    }
}
