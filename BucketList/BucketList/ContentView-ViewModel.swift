//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Vinz on 6/23/25.
//

import LocalAuthentication
import Foundation
import MapKit
import CoreLocation

extension ContentView {
    @Observable
    class ViewModel {
        
        private(set) var locations = [Location]()
        var selectedPlace: Location?
        var isUnlocked = false
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        // Day 73 Coding Challenge
        var faceIDError = false
        var bioMetricsError = false
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            // create a new location 
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            // add the coordinates to locations array
            locations.append(newLocation)
        }
        
        func updateLocation(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                        // Day 73 Coding Challenge
                        self.faceIDError = true
                    }
                }
            } else {
                // Day 73 Coding Challenge
                self.bioMetricsError = true
            }
        }
    }
}
