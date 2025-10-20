import SwiftUI

private struct OptionallyHiddenModifier: ViewModifier {
    let hidden: Bool

    func body(content: Content) -> some View {
        if hidden {
            content
                .hidden()
                .disabled(true)
        } else {
            content
        }
    }
}

extension View {
    func optionallyHidden(_ isHidden: Bool) -> some View {
        self.modifier(OptionallyHiddenModifier(hidden: isHidden))
    }
}
