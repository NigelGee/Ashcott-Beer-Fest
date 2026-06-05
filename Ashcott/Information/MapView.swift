//
//  MapView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition

    /// The coordinates of the venue.
    var coordinate: CLLocationCoordinate2D
    var name: String

    init(loc: Location) {
        let meters = 1000.0
        self.coordinate = loc.coordinates
        self._cameraPosition = State(initialValue: MapCameraPosition.region(MKCoordinateRegion(center: coordinate, latitudinalMeters: meters, longitudinalMeters: meters)))
        name = loc.name
    }


    var body: some View {
        Button {
            let destination = MKMapItem(placemark: .init(coordinate: coordinate))
            destination.name = name
            destination.openInMaps()
        } label: {
            ZStack(alignment: .bottom) {
                Map(position: $cameraPosition) {
                    UserAnnotation()
                    Annotation(coordinate: coordinate) {
                        ZStack {
                            Circle()
                                .frame(width: 30)
                                .overlay {
                                    Text("🍻")
                                        .offset(x: 0, y: 1)
                                }
                        }
                    } label: {
                        Text(name)
                    }
                }
            }
        }
    }
}

#Preview("Light") {
    MapView(loc: .example)
}

#Preview("Dark") {
    MapView(loc: .example)
        .preferredColorScheme(.dark)
}
