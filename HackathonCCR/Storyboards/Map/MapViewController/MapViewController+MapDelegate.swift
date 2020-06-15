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
        
        loadContent()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation as? CommercialFacilityAnnotation  != nil else {return nil}
        
        var view: MKAnnotationView?
    
        view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if let markerView = view as? MKMarkerAnnotationView {
       
            markerView.markerTintColor = UIColor.AppColors.green
        }
        
        return view
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let annotation = view.annotation as? CommercialFacilityAnnotation {
            self.performSegue(withIdentifier: Segues.annotationInformations.rawValue, sender: annotation)
        }
    }
}
