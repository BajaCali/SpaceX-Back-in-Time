import SwiftUI

// MARK: - Struct

struct LaunchDetail {
    let launch: Launch

    init(_ launch: Launch) {
        self.launch = launch
    }
}

// MARK: - View

extension LaunchDetail: View {
    var body: some View {
        List {
            images
            infoSection
            moreDetailsSection
            discussionsSection
        }
    }
}

// MARK: - Sections

extension LaunchDetail {
    var images: some View {
        ImagesView(
            patch: launch.patch?.large,
            images: launch.flickr?.original ?? []
        )
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }

    var infoSection: some View {
        Section("Mission Details") {
            InfoRow(label: "Mission", value: launch.title)
            InfoRow(label: "Flight Number", value: "\(launch.flightNumber)")
            InfoRow(label: "Date", value: launch.date.formatted(date: .long, time: .shortened))
            if let details = launch.details {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Details")
                        .font(.headline)
                    Text(details)
                        .font(.body)
                }
                .padding(.vertical, 4)
            }
        }
    }

    @ViewBuilder
    var moreDetailsSection: some View {
        if launch.hasLinks {
            Section {
                if let wikipediaURL = launch.wikipediaURL {
                    Link(destination: wikipediaURL) {
                        Label("Wikipedia", systemImage: "globe")
                    }
                }
                if let articleURL = launch.articleURL {
                    Link(destination: articleURL) {
                        Label("Article", systemImage: "newspaper")
                    }
                }
                if let youtubeURL = launch.youtubeURL {
                    Link(destination: youtubeURL) {
                        Label("YouTube", systemImage: "play.tv")
                    }
                }
                if let presskitURL = launch.presskitURL {
                    Link(destination: presskitURL) {
                        Label("Presskit", systemImage: "doc.text")
                    }
                }
            } header: {
                Label("More Info", systemImage: "globe")
            }
        }
    }

    @ViewBuilder
    var discussionsSection: some View {
        if launch.hasRedditLinks {
            Section {
                if let campaignURL = launch.reddit?.campaign {
                    Link("Campaign", destination: campaignURL)
                }
                if let launchURL = launch.reddit?.launch {
                    Link("Launch", destination: launchURL)
                }
                if let mediaURL = launch.reddit?.media {
                    Link("Media", destination: mediaURL)
                }
                if let recoveryURL = launch.reddit?.recovery {
                    Link("Recovery", destination: recoveryURL)
                }
            } header: {
                Label("Discussion", systemImage: "person.2.wave.2.fill")
            }

        }
    }
}

// MARK: - Support Views

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ImagesView: View {
    let patch: URL?
    let images: [URL]

    @State private var size: CGSize = .zero

    var body: some View {
        if let patch {
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
        }
    }
}

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

// MARK: - Preview

#Preview {
    let launch = Launch.withImages

    NavigationStack {
        LaunchDetail(launch)
            .navigationTitle(launch.title)
    }
}
