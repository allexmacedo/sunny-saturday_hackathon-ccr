//
//  CommercialFacility.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 13/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation

struct CommercialFacility: Codable {
    
    let id: UUID
    
    let name: String
    
    let category: String
    
    let rating: Double
}
