//
//  MapViewController+Location.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import MapKit

extension MapViewController {
    
    private var defaultSpan: MKCoordinateSpan {
        return MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    }
    
    func requestAuthorizationForLocation(completion: (() -> Void)?) {
        
        locationServices.requestAuthorization { (result) in
            
            switch result {
                
                case .success:
                    print("\(self): Successfully read user location")
                
                case .failure(let error):
                    self.handleAuthorizationError(error: error)
            }
            
            completion?()
        }
    }
    
    func centerMapOnUserLocation() {
        
        locationServices.retriveUserLocation { (result) in
            
            switch result {
                
                case .success(let location):
                    self.centerMapOnCoordinate(location: location.coordinate, coordinateSpan: self.defaultSpan)
                
                case .failure(let error):
                    self.handleAuthorizationError(error: error)
            }
        }
    }
    
    /// Function for center map region
    /// - Parameter location: location that will be the center of the map
    func centerMapOnCoordinate(location: CLLocationCoordinate2D, coordinateSpan: MKCoordinateSpan? = nil) {
        
        let span = coordinateSpan ?? mapView.region.span
        
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func handleAuthorizationError(error: LocationError) {
        
        switch error {
            
            case .userAlreadyDeniedAccess:
                self.presentInformativeAlert(title: "Acesso à localização",
                                             withMessage: "Autorize o acesso aos serviços de localizações para uma melhor experiência")
            default:
                print("Unsolved error at \(self): \(error.rawValue)")
        }
    }
}
