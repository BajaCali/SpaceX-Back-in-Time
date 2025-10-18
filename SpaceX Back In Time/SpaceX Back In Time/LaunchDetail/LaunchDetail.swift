import SwiftUI
import Dependencies

// MARK: - Struct

struct LaunchDetail {
    @State private var launch: Launch

    init(_ launch: Launch) {
        self.launch = launch
    }

    @Dependency(EventBroker.self) var eventBroker
}

// MARK: - Business Logic

extension LaunchDetail {
    private func nextLaunchButtonTapped() {
        eventBroker.post(.detail(.nextLaunchButtonTapped))
    }

    private func onDisappear() {
        eventBroker.post(.detail(.dismissing))
    }

    private func onAppear() {
        eventBroker.listen(.reusing(via: "LauchDetail"), handleEvents(_:))
    }

    private func handleEvents(_ event: Event) {
        switch event {
        case let .detail(.updateLaunchInDetail(launch, hasNext: hasNext, hasPrev: hasPrev)):
            self.launch = launch
            return
        default: return
        }
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
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Next Launch", systemImage: "arrow.down.circle", action: nextLaunchButtonTapped)
            }
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

// MARK: - Preview

#Preview {
    let launch = Launch.withImages

    NavigationStack {
        LaunchDetail(launch)
            .navigationTitle(launch.title)
    }
}
