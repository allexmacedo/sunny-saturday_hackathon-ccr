//
//  DirectionsDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import CoreLocation
import MapKit

protocol DirectionsDataStore {
    
    /// Compute routes from diferents points
    /// - Parameters:
    ///   - origin: Origin of the route
    ///   - destinations: Destination of the route
    ///   - completion: Result of route calc, with routes or error if there is one
    func calculateDirections(from origin: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping (Result<[MKRoute], DirectionsError>) -> Void)
}

enum DirectionsError: String, Error {
    case emptyRoutes            = "The request returned an empty result of routes"
    case emptyResponse          = "The request returned an empty response"
    case errorDuringComputation = "The calculate reponse returned an error"
}

class DirectionsDAO: DirectionsDataStore {
    
    /// Compute routes from diferents points
    /// - Parameters:
    ///   - origin: Origin of the route
    ///   - destinations: Destination of the route
    ///   - completion: Result of route calc, with routes or error if there is one
    func calculateDirections(from origin: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping (Result<[MKRoute], DirectionsError>) -> Void) {
        
        let directions = MKDirections(request: buildDirectionsRequest(from: origin, to: destination))
        
        directions.calculate { response, error in
            
            if error == nil {
                
                if let response = response {
                    
                    if !response.routes.isEmpty {
                        completion(.success(response.routes))
                        
                    } else {
                        completion(.failure(DirectionsError.emptyRoutes))
                    }
                    
                } else {
                    completion(.failure(DirectionsError.emptyResponse))
                }
                
            } else {
                completion(.failure(DirectionsError.errorDuringComputation))
            }
        }
    }

    private func buildDirectionsRequest(from origin: CLLocationCoordinate2D,
                                        to destination: CLLocationCoordinate2D) -> MKDirections.Request {
        
        let request = MKDirections.Request()
        
        request.source      = MKMapItem(placemark: MKPlacemark(coordinate: origin))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        request.requestsAlternateRoutes = false
        
        request.transportType = .automobile
        
        return request
    }
}
