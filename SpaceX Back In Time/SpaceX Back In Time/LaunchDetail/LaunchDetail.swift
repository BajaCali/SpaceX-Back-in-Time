import SwiftUI

struct LaunchDetail: View {
    let launch: Launch

    init(_ launch: Launch) {
        self.launch = launch
    }

    var body: some View {
        VStack {
            Text("LaunchDetailView")
                .font(.title)
            Text(launch.title)
        }
    }
}
