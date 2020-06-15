//
//  CommercialFacilityAnnotation.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import MapKit

class CommercialFacilityAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var facility: CommercialFacility
    
    init(from model: CommercialFacility) {
        
        self.coordinate = model.location.coordinate
        self.facility = model
        
        super.init()
    }
}
