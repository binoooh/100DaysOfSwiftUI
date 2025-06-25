//
//  ContentView.swift
//  BucketList
//
//  Created by Vinz on 6/21/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // create a state property for our view model
    @State private var viewModel = ViewModel()
    // selection for map modes
    @State private var mapStyleMode:MapStyle = .standard // Day 73 Coding Challenge
    // create a starting position property for the map
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    ))
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .top) {
                VStack {
                    // use map reader to read the data from the map
                    MapReader { proxy in
                        // set the map's initial position
                        Map(initialPosition: startPosition) {
                            // get the contents of the locations array
                            ForEach(viewModel.locations) { location in
                                // then place an annotation to the map for each coordinates from the locations array
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture(minimumDuration: 0.2) {
                                            viewModel.selectedPlace = location
                                            print(location.name)
                                        }
                                }
                            }
                        }
                        // get the coordinates where the user tapped
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local ) {
                                viewModel.addLocation(at: coordinate)
                                viewModel.save()
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.updateLocation(location: $0)
                                viewModel.save()
                            }
                        }
                    }
                    // Day 73 Coding Challenge
                    .mapStyle(mapStyleMode)
                }
                // Day 73 Coding Challenge
                HStack(spacing: 8) {
                    Button("Standard") {
                        mapStyleMode = .standard
                    }
                    .buttonStyle(GrowingButton())
                    Button("Hybrid") {
                        mapStyleMode = .hybrid
                    }
                    .buttonStyle(GrowingButton())
                }
                
            }
            // Day 73 Coding Challenge
            .alert("Face ID Error", isPresented: $viewModel.faceIDError) {
                Button("Please try again.", role: .cancel) {}
            }
            // Day 73 Coding Challenge
            .alert("No Biometrics", isPresented: $viewModel.bioMetricsError) {
                Button("Unsupported Device.", role: .cancel) {}
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
