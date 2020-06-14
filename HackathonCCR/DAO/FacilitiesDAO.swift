//
//  FacilitiesDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import CoreLocation

protocol FacilitiesDataStore {
    
    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], FacilitiesError>) -> Void)
}

final class FacilitiesDAO: FacilitiesDataStore {
    
    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], FacilitiesError>) -> Void) {
        
        completion(.success([CommercialFacility(id: UUID(), name: "Graal Paloma",
                                                category: category, image: "graal", rating: 4.5,
                                                coordinate: CLLocation(latitude: -22.8061941, longitude: -49.531047))]))
    }
}
