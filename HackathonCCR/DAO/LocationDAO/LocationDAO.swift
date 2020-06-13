//
//  LocationDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import CoreLocation

final class LocationDAO: NSObject {
    
    lazy var locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    
        return manager
        
    }()
    
    static let sharedInstance = LocationDAO()
}
