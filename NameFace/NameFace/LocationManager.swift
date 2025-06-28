//
//  LocationManager.swift
//  NameFace
//
//  Created by bino on 6/27/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced // Balance accuracy and battery
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // Start getting location updates
    }
    
    // Gets the last known location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
    }
    
    // Fail safe error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location authorized.")
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location acess denied or restricted")
        case .notDetermined:
            print("Location authorization not determined.")
        @unknown default:
            break
        }
    }
}
