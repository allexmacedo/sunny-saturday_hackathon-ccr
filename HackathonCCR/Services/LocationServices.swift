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
    func retriveUserLocation(completion: @escaping (Result<CLLocation, Error>) -> Void)
    
    /// Requests authorization to acess user location
    /// - Parameter completion: Clousure that an error if it occurs
    func requestAuthorization(completion: ((Result<Void, Error>) -> Void)?)
    
    /// Reads the current city of the user
    /// - Parameter completion: Clousure that returns the city name or error if it occurs
    func retriveCurrentLocationLabels(completion: @escaping (Result<Location, Error>) -> Void)
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, Error>) -> Void)
    
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
            
            self.retriveUserLocation { result in
               
                switch result {
                    
                    case .success(let location):
                        self.geocoderDataStore.retriveLocationName(from: location, completion: completion)
                    
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, Error>) -> Void) {
        let blockForExecutionInMain = BlockOperation {
            self.geocoderDataStore.retriveCityLocation(cityName: cityName, completion: completion)
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func retriveUserLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        
        let blockForExecutionInMain = BlockOperation {
            
            do {
                
                let location = try self.locationDataStore.retriveCurrentUserLocation()
                
                completion(.success(location))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func requestAuthorization(completion: ((Result<Void, Error>) -> Void)?) {
        
        let blockForExecutionInMain = BlockOperation {
                        
            do {
                
                try self.locationDataStore.requestLocationAuthorization()
                
                completion?(.success(Void()))
                
            } catch {
                completion?(.failure(error))
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func registerForAuthorizationChangeNotification(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector,
                                               name: LocationChangeNotification.authorizationDidChange.name, object: nil)
    }
}
