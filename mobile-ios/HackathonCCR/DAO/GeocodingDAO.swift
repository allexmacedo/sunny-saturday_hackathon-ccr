//
//  GeocodingDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation
import CoreLocation

protocol GeocodingDataStore {
    
    /// Reads the current city of the user
    /// - Parameter completion: Clousure that returns the city name or error if it occurs
    func retriveLocationName(from location: CLLocation, completion: @escaping (Result<Location, LocationError>) -> Void)
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, LocationError>) -> Void)
}

final class GeocodingDAO: GeocodingDataStore {
    
    private let geocoder = CLGeocoder()
    
    // Reads the current city of the user
    /// - Parameter completion: Clousure that returns the city name or error if it occurs
    func retriveLocationName(from location: CLLocation, completion: @escaping (Result<Location, LocationError>) -> Void) {
                
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale.current) { (placemarks, error) in
            
            if error == nil,
                let placemark = placemarks?.first,
                let cityName = placemark.locality,
                let stateName = placemark.administrativeArea,
                let countryName = placemark.country {
                
                let location = Location(city: cityName, state: stateName, country: countryName)
                
                completion(.success(location))
                
            } else {
                completion(.failure(LocationError.reverseGeocodingError))
            }
        }
    }
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, LocationError>) -> Void) {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(cityName) { (placemarks, error) in
            
            if error == nil, let placemarks = placemarks, let location = placemarks.first?.location {
                completion(.success(location))
                
            } else {
                completion(.failure(LocationError.reverseGeocodingError))
            }
        }
    }
}
