import SwiftUI

struct LoadingRow: View {
    var body: some View {
        HorizontalProgressView()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
