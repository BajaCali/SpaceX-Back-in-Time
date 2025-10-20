import SwiftUI
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    let markerTitle: String

    var body: some View {
        Section("Launchpad Location") {
            Map(initialPosition: .region(region)) {
                Marker(markerTitle, coordinate: coordinate)
            }
            .frame(minHeight: 200)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
        )
    }
}

#Preview {
    // swiftlint:disable:next force_try
    let launchpad = try! JSONDecoder().decode(Launchpad.self, from: Launchpad.example)

    List {
        MapView(
            coordinate: .init(
                latitude: launchpad.latitude,
                longitude: launchpad.longitude
            ),
            markerTitle: launchpad.name
        )
    }
}
