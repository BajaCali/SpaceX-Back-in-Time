import SwiftUI

// MARK: - Struct

extension LaunchDetail {
    struct ImagesView {
        let patch: URL?
        let images: [URL]
        @State private var showImagesButtonNotYetTapped = true
        @State private var scrollProxy: ScrollViewProxy?
        @State private var size: CGSize = .zero
    }
}

// MARK: - Business Logic

extension LaunchDetail.ImagesView {
    func scrollToFirstPhotoButtonTapped() {
        if let image = self.images.first {
            withAnimation(.bouncy) {
                scrollProxy?.scrollTo(image)
            }
        }
    }
}

// MARK: - View

extension LaunchDetail.ImagesView: View {
    var body: some View {
        if let patch {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ImageWithHorizontalBorders(url: patch, width: size.width)
                        ForEach(images, id: \.self) { url in
                            ImageWithHorizontalBorders(url: url, width: size.width)
                        }
                    }
                }
                .frame(height: 200)
                .scrollTargetBehavior(.paging)
                .sizeReader($size)
                .overlay {
                    slideToFirstImageButton
                }
                .onAppear {
                    scrollProxy = proxy
                }
            }
        }
    }
}

// MARK: - Parts

extension LaunchDetail.ImagesView {
    @ViewBuilder
    var slideToFirstImageButton: some View {
        if images.isNotEmpty && showImagesButtonNotYetTapped {
            Button(
                "Show Image",
                systemImage: "arrow.up.right.bottomleft.rectangle.fill"
            ) {
                scrollToFirstPhotoButtonTapped()
                showImagesButtonNotYetTapped.toggle()
                print("Button tapped")
            }
            .buttonStyle(.borderless)
            .transition(.symbolEffect.animation(.default.speed(0.7)))
            .padding(.horizontal)
            .tint(.secondary)
            .labelStyle(.iconOnly)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}
