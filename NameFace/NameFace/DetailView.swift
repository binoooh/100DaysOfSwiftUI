//
//  DetailView.swift
//  NameFace
//
//  Created by bino on 6/27/25.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    let namedPhoto: NamedPhoto
    @State private var mapRegion: MKCoordinateRegion
    
    init(namedPhoto: NamedPhoto) {
        self.namedPhoto = namedPhoto
        _mapRegion = State(initialValue: MKCoordinateRegion(center: namedPhoto.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
    }
    
    var body: some View {
        VStack {
            if let uiImage = loadImage(from: namedPhoto.photoPath) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                Text("Image not found!")
                    .padding()
            }
            
            Map(coordinateRegion: $mapRegion, annotationItems: [namedPhoto]) { photo in
                MapMarker(coordinate: photo.coordinate)
            }
            .frame(height: 300)
            .cornerRadius(10)
            .padding()
        }
        .navigationTitle(namedPhoto.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadImage(from url: URL) -> UIImage? {
        do {
            let data = try(Data(contentsOf: url))
            return UIImage(data: data)
        } catch {
            print("Error loading image from \(url.lastPathComponent): \(error.localizedDescription)")
            return nil
        }
    }
}

//#Preview {
//    DetailView()
//}
