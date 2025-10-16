import SwiftUI

struct ToolbarButton: View {
    let action: () -> Void

    var body: some View {
        Button("TestButton", systemImage: "plus", action: action)
    }
}
