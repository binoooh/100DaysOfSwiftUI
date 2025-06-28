//
//  Friend.swift
//  NameFace
//
//  Created by bino on 6/27/25.
//

import SwiftUI
import CoreLocation

struct NamedPhoto: Codable, Identifiable {
    var id = UUID()
    var name: String
    var photoPath: URL
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(id: UUID = UUID(), photoPath: URL, latitude: Double, longitude: Double) {
        self.id = id
        self.name = "New Photo"
        self.photoPath = photoPath
        self.latitude = latitude
        self.longitude = longitude
    }
}
