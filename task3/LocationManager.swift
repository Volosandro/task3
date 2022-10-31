//
//  LocationManager.swift
//  task3
//
//  Created by Volosandro on 31.10.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate
{
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    
    func startLocationUpdate()
    {
        self.requestAuthorizationIfNeeded()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.showsBackgroundLocationIndicator = true
        DispatchQueue.main.async{
            self.locationManager.startUpdatingLocation()
        }
    }

    func requestAuthorizationIfNeeded()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            if (authorizationStatus == .notDetermined)
            {
                locationManager.requestAlwaysAuthorization()
            }
        }
    }
}
