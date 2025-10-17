import SwiftUI

struct SizeReaderViewModifier: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.size = proxy.size
                        }
                        .onChange(of: proxy.size) { _, newSize in
                            self.size = newSize
                        }
                }
            }
    }
}

// MARK: - View Extensions

public extension View {
    func sizeReader(_ size: Binding<CGSize>) -> some View {
        modifier(SizeReaderViewModifier(size: size))
    }
}
