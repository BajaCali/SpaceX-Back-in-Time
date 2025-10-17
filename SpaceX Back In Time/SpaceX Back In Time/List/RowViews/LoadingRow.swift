import SwiftUI

struct LoadingRow: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
