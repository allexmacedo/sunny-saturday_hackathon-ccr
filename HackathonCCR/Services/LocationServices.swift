//
//  LocationServices.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 29/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol LocationBusinessLogic: AnyObject {
    
    /// Reads the current location of the user
    /// - Parameter completion: Clousure that returns the user location or error if it occurs
    func retriveUserLocation(completion: @escaping (_ userLocation: CLLocation?, _ error: Error?) -> Void)
    
    /// Requests authorization to acess user location
    /// - Parameter completion: Clousure that an error if it occurs
    func requestAuthorization(completion: ((_ error: Error?) -> Void)?)
    
    /// Reads the current city of the user
    /// - Parameter completion: Clousure that returns the city name or error if it occurs
    func retriveCurrentLocationLabels(completion: @escaping (Result<Location, Error>) -> Void)
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (_ cityLocation: CLLocation?, _ error: Error?) -> Void)
    
    /// Add an object as an observer to observe any changes on Location authorizations
    /// - Parameters:
    ///   - observer: The object that will observe
    ///   - selector: The Selector method 
    func registerForAuthorizationChangeNotification(observer: Any, selector: Selector)
}

final class LocationServices: LocationBusinessLogic {
    
    var locationDataStore: LocationDataStore = LocationDAO.sharedInstance
    
    var geocoderDataStore: GeocodingDataStore = GeocodingDAO()
        
    func retriveCurrentLocationLabels(completion: @escaping (Result<Location, Error>) -> Void) {
        
        let blockForExecutionInMain = BlockOperation {
            
            self.retriveUserLocation { (location, error) in
                if error == nil, let location = location {
                    self.geocoderDataStore.retriveLocationName(from: location, completion: completion)
                    
                } else {
                    completion(.failure(error!))
                }
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func retriveCityLocation(cityName: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        let blockForExecutionInMain = BlockOperation {
            self.locationDataStore.retriveCityLocation(cityName: cityName, completion: completion)
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func retriveUserLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        
        let blockForExecutionInMain = BlockOperation {
            
            do {
                
                let location = try self.locationDataStore.retriveCurrentUserLocation()
                
                completion(location, nil)
                
            } catch {
                completion(nil, error)
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func requestAuthorization(completion: ((Error?) -> Void)?) {
        
        let blockForExecutionInMain = BlockOperation {
            
            var raisedError: Error?
            
            do {
                
                try self.locationDataStore.requestLocationAuthorization()
                
            } catch {
                raisedError = error
            }
            
            if let completion = completion {
                completion(raisedError)
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func registerForAuthorizationChangeNotification(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector,
                                               name: LocationChangeNotification.authorizationDidChange.name, object: nil)
    }
}
