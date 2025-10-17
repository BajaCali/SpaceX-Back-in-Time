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
                .clipped()
                .cornerRadius(8)
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, alignment: .center)
    }
}
