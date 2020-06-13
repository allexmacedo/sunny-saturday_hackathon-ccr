//
//  LocationDAO+LocationDataStore.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import CoreLocation

protocol LocationDataStore: AnyObject {
    
    /**
     Reads the current location of the user
     
     - Throws: `LocationError.nilLocation` if the location is empty
     
     - Returns: The user current location
     */
    func retriveCurrentUserLocation() throws -> CLLocation
    
    /**
     Requests authorization to acess user location
     
     - Throws: Error that warns if the user has already denied access to location,
     if there is an not handled option of authorization or if the app is restricted to access the location
     */
    func requestLocationAuthorization() throws
    
}

extension LocationDAO: LocationDataStore {
    
    
    func retriveCurrentUserLocation() throws -> CLLocation {
        
        guard let location = locationManager.location else {
            throw LocationError.nilLocation
        }
        
        return location
    }
    
    func requestLocationAuthorization() throws {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined, nil:
            locationManager.requestWhenInUseAuthorization()
            
        case .denied:
            throw LocationError.userAlreadyDeniedAccess
            
        case .restricted:
            throw LocationError.localizationRestricted
            
        case .authorizedWhenInUse, .authorizedAlways:
            return
            
        @unknown default:
            throw LocationError.frameworkError
        }
    }
}
