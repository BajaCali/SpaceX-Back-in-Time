import SwiftUI
import Dependencies

// MARK: - Struct

struct LaunchDetailView {
    @State private var viewModel: ViewModel

    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Derived Properites

extension LaunchDetailView {
    var state: ViewModel.State { viewModel.state }
    var launch: Launch { state.launch }
}

// MARK: - View

extension LaunchDetailView: View {
    var body: some View {
        List {
            images
            infoSection
            moreDetailsSection
            discussionsSection
        }
        .id(launch.id)
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
        .toolbar(content: toolbar)
    }
}

// MARK: - View Components

extension LaunchDetailView {
    func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if state.hasPrev || state.hasNext {
                HStack {
                    Button(
                        "Previous Launch",
                        systemImage: "arrow.up",
                        action: viewModel.prevLaunchButtonTapped
                    )
                    .transition(.scale)
                    .font(.caption2)
                    .optionallyHidden(state.hasPrev == false)

                    Button(
                        "Next Launch",
                        systemImage: "arrow.down.circle",
                        action: viewModel.nextLaunchButtonTapped
                    )
                    .optionallyHidden(state.hasNext == false)
                }
                .tint(.primary)
            }
        }
    }
}

// MARK: - Sections

extension LaunchDetailView {
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

// MARK: - Preview

#Preview {
    let launch = Launch.withImages

    NavigationStack {
        LaunchDetailView(.init(launch: launch, hasNext: false, hasPrev: true))
            .navigationTitle(launch.title)
    }
}
