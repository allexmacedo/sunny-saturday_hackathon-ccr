//
//  FacilityCategory.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation

struct FacilityCategory: Codable {
    
    let id: Int?
    let name: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id          = "cat_id"
        case name        = "cat_name"
        case description = "cat_description"
    }
}
