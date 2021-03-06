//
//  MKMapView+drawRoute.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright (c) 2020 Equipe261. All rights reserved.

import MapKit

extension MKMapView {
    
    func addRouteOverlay(route: MKRoute) {
        self.addOverlay(route.polyline)
    }
}
