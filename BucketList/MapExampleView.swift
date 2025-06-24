//
//  MapExampleView.swift
//  BucketList
//
//  Created by Vinz on 6/22/25.
//

import MapKit
import SwiftUI

struct Locations: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapExampleView: View {
    
    let locations = [
        Locations(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Locations(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        
        Map {
            ForEach(locations) { location in
                //Marker(location.name, coordinate: location.coordinate)
                Annotation(location.name, coordinate: location.coordinate) {
                    Text(location.name)
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                .annotationTitles(.hidden)
            }
        }
        
//        Map(position: $position)
//        // onMapCameraChange() modifier that tells us when the position changes,
//        // either immediately or once movement has ended.
//            .onMapCameraChange(frequency: .continuous) { context in
//                    print(context.region)
//            }
//        
//        HStack(spacing: 50) {
//            Button("Paris") {
//                position = MapCameraPosition.region(
//                    MKCoordinateRegion(
//                        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
//                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                    )
//                )
//            }
//            
//            Button("Tokyo") {
//                position = MapCameraPosition.region(
//                    MKCoordinateRegion(
//                        center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
//                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                    )
//                )
//            }
//        }
    }
}

#Preview {
    MapExampleView()
}
