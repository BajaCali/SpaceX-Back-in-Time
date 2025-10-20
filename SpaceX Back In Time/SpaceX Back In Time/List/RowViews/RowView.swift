import SwiftUI

struct RowView: View {
    let launch: Launch

    var body: some View {
        HStack(spacing: 16) {
            patch
            titleAndDate
            Spacer()
            infoIcons
        }
        .padding(.vertical, 8)
    }

    var patch: some View {
        Group {
            if let patchURL = launch.patch?.small {
                AsyncImage(url: patchURL) { image in
                    image.resizable()
                        .transition(.scale)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(Resources.Image.spaceXIcon)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .frame(width: 48, height: 48)
    }

    var titleAndDate: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(launch.title)
                .font(.headline)
            Text(launch.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    var infoIcons: some View {
        if !(launch.flickr?.original.isEmpty ?? true) {
            Image(systemName: "photo.on.rectangle.angled")
        }

        if !launch.success {
            Text("💥")
        }
    }
}

#Preview {
    RowView(launch: .withImages)
}
