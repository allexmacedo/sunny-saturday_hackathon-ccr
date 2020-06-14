//
//  MapViewController+MapDelegate.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func configureMapView() {
        mapView.delegate = self
        
        centerMapOnUserLocation()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.performSegue(withIdentifier: Segues.annotationInformations.rawValue, sender: nil)
    }
}
