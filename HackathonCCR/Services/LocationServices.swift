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
    func retriveUserLocation(completion: @escaping (Result<CLLocation, LocationError>) -> Void)
    
    /// Requests authorization to acess user location
    /// - Parameter completion: Clousure that an error if it occurs
    func requestAuthorization(completion: ((Result<Void, LocationError>) -> Void)?)
    
    /// Reads the current city of the user
    /// - Parameter completion: Clousure that returns the city name or error if it occurs
    func retriveCurrentLocationLabels(completion: @escaping (Result<Location, LocationError>) -> Void)
    
    /// Retrive the location of a specific city
    /// - Parameters:
    ///   - cityName: The city used to request the location
    ///   - completion: Clousure that returns the city location or error if it occurs
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, LocationError>) -> Void)
    
    /// Add an object as an observer to observe any changes on Location authorizations
    /// - Parameters:
    ///   - observer: The object that will observe
    ///   - selector: The Selector method 
    func registerForAuthorizationChangeNotification(observer: Any, selector: Selector)
    
    /// Compute routes from diferents points
    /// - Parameters:
    ///   - origin: Origin of the route
    ///   - destinations: Destination of the route
    ///   - completion: Result of route calc, with routes or error if there is one
    func calculateDirections(from origin: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping (Result<MKRoute, DirectionsError>) -> Void)
    
}

final class LocationServices: LocationBusinessLogic {
    
    var locationDataStore: LocationDataStore = LocationDAO.sharedInstance
    
    var geocoderDataStore: GeocodingDataStore = GeocodingDAO()
    
    var directionsDataStore: DirectionsDataStore = DirectionsDAO()
        
    func retriveCurrentLocationLabels(completion: @escaping (Result<Location, LocationError>) -> Void) {
        
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
    
    func retriveCityLocation(cityName: String, completion: @escaping (Result<CLLocation, LocationError>) -> Void) {
        let blockForExecutionInMain = BlockOperation {
            self.geocoderDataStore.retriveCityLocation(cityName: cityName, completion: completion)
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func retriveUserLocation(completion: @escaping (Result<CLLocation, LocationError>) -> Void) {
        
        let blockForExecutionInMain = BlockOperation {
            
            do {
                
                let location = try self.locationDataStore.retriveCurrentUserLocation()
                
                completion(.success(location))
                
            } catch let error as LocationError {
                completion(.failure(error))
                
            } catch {
                completion(.failure(LocationError.nilLocation))
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func requestAuthorization(completion: ((Result<Void, LocationError>) -> Void)?) {
        
        let blockForExecutionInMain = BlockOperation {
                        
            do {
                
                try self.locationDataStore.requestLocationAuthorization()
                
                completion?(.success(Void()))
                
            } catch let error as LocationError {
                completion?(.failure(error))
                
            } catch {
                completion?(.failure(LocationError.nilLocation))
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
    }
    
    func registerForAuthorizationChangeNotification(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector,
                                               name: LocationChangeNotification.authorizationDidChange.name, object: nil)
    }
    
    /// Compute routes from diferents points
    /// - Parameters:
    ///   - origin: Origin of the route
    ///   - destinations: Destination of the route
    ///   - completion: Result of route calc, with routes or error if there is one
    func calculateDirections(from origin: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping (Result<MKRoute, DirectionsError>) -> Void) {
        
        let blockForExecutionInBackground = BlockOperation {
            
            self.directionsDataStore.calculateDirections(from: origin, to: destination) { (result) in
             
                switch result {
                    
                    case .success(let routes):
                        
                        var sortedRoutes = routes
                        
                        sortedRoutes.sort {$0.expectedTravelTime < $1.expectedTravelTime}
                    
                        if let firstRoute = sortedRoutes.first {
                            completion(.success(firstRoute))
                            
                        } else {
                            completion(.failure(DirectionsError.emptyRoutes))
                    }
                    
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: .serial)
    }
}
