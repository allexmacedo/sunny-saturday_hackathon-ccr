//
//  LocationDAO+LocationManagerDelegate.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import CoreLocation

enum LocationChangeNotification: String {
    
    case authorizationDidChange = "UserAuthorizationNotification"
    
    var name: Notification.Name {
        return Notification.Name(self.rawValue)
    }
}

extension LocationDAO: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        NotificationCenter.default.post(name: LocationChangeNotification.authorizationDidChange.name, object: nil)
    }
}
