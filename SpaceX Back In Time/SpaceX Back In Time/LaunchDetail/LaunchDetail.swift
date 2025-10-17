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
            patch
            infoSection
            moreDetailsSection
            discussionsSection
            photosSections
        }
    }
}

// MARK: - Sections

extension LaunchDetail {
    var patch: some View {
        Section {
            PatchImageView(url: launch.patch?.large ?? launch.patch?.small)
        }
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

    @ViewBuilder
    var photosSections: some View {
        if let flickr = launch.flickr, flickr.original.isNotEmpty {
            Section("Photos") {
                FlickrImageViewer(urls: flickr.original)
            }
        }
    }
}

// MARK: - Support Views

struct PatchImageView: View {
    let url: URL?

    var body: some View {
        if let url {
            HStack {
                Spacer()
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .padding()
                Spacer()
            }
        }
    }
}

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

struct FlickrImageViewer: View {
    let urls: [URL]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(urls, id: \.self) { url in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let launch = Launch.mockLaunches.first!

    NavigationStack {
        LaunchDetail(launch)
            .navigationTitle(launch.title)
    }
}
