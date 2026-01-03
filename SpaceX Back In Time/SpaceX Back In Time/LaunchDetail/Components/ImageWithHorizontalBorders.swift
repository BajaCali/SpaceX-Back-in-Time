import SwiftUI

struct ImageWithHorizontalBorders: View {
    let url: URL
    let width: CGFloat

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 16, style: .continuous))
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, alignment: .center)
    }
}
