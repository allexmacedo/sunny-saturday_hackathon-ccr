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
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (_ cityLocation: CLLocation?, _ error: Error?) -> Void)
}

extension LocationDAO: LocationDataStore {
    
    func retriveCityLocation(cityName: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            if error == nil, let placemarks = placemarks, let location = placemarks.first?.location {
                completion(location, nil)
                
            } else {
                completion(nil, LocationError.reverseGeocodingError)
            }
        }
    }
    
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
