import SwiftUI

// MARK: - Struct

extension LaunchDetailView {
    struct ImagesView {
        let patch: URL?
        let images: [URL]
        @State private var showImagesButtonNotYetTapped = true
        @State private var firstImageShownAlready = false
        @State private var displayImages = false
        @State private var scrollProxy: ScrollViewProxy?
        @State private var size: CGSize = .zero
    }
}

// MARK: - Business Logic

extension LaunchDetailView.ImagesView {
    func scrollToFirstPhotoButtonTapped() {
        if let image = self.images.first {
            withAnimation(.bouncy) {
                scrollProxy?.scrollTo(image)
            }
        }
    }
}

// MARK: - View

extension LaunchDetailView.ImagesView: View {
    var body: some View {
        if let patch {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ImageWithHorizontalBorders(url: patch, width: size.width)
                        if displayImages {
                            ForEach(images, id: \.self) { url in
                                ImageWithHorizontalBorders(url: url, width: size.width)
                                    .onScrollVisibilityChange(threshold: 0.9) { visible in
                                        guard visible else { return }
                                        firstImageShownAlready = true
                                    }
                            }
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
                .onChange(of: size) { (_, _) in
                    displayImages = true
                }
            }
        }
    }
}

// MARK: - Parts

extension LaunchDetailView.ImagesView {
    private var shouldShowSlideToFirstImageButton: Bool {
        images.isNotEmpty && showImagesButtonNotYetTapped && firstImageShownAlready == false
    }

    @ViewBuilder
    var slideToFirstImageButton: some View {
        if shouldShowSlideToFirstImageButton {
            Button(
                "Show Image",
                systemImage: "arrow.up.right.bottomleft.rectangle.fill"
            ) {
                scrollToFirstPhotoButtonTapped()
                showImagesButtonNotYetTapped.toggle()
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
