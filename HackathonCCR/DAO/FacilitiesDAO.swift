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
        
        completion(.success([CommercialFacility(id: UUID(),
                                                name: "Graal Paloma",
                                                category: [.gas, .repair, .resting, .tireShop],
                                                description: "A Rede Graal é uma rede de auto-postos rodoviários do Brasil, sendo conhecida pelos seus amplos e modernos rodoshoppings. Está presente em algumas das principais rodovias nos estados de São Paulo, Minas Gerais, Rio de Janeiro, Santa Catarina e Rio Grande do Sul.",
                                                address: " Rodovia Engenheiro João Baptista Cabral Rennó,s/n - Zona Rural, Santa Cruz do Rio Pardo - SP, 18900-000",
                                                timeOfWork: "Aberto 24h",
                                                phone: "(14) 3332-1033",
                                                image: "graal",
                                                rating: 4.5,
                                                verified: true,
                                                coordinate: CLLocation(latitude: -22.8061941, longitude: -49.531047))]))
    }
}
