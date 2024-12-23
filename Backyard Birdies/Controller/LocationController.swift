//
//  LocationController.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 11/12/2024.
//

import Foundation
import CoreLocation

@Observable
@MainActor
class LocationController {
    private var locationManager: CLLocationManager
    var lastLocation = CLLocation()
    
    init(){
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        Task {
            do {
                let updates = CLLocationUpdate.liveUpdates()
                for try await update in updates{
                    if let loc = update.location{
                        self.lastLocation = loc
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}


