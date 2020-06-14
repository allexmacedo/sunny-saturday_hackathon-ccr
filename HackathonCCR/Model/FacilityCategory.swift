//
//  FacilityCategory.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation

enum FacilityCategory: String, CaseIterable, Codable {
    
    case suport       = "Pontos de apoio"
    case hotels       = "Hotéis"
    case resting      = "Área de descanso"
    case gas          = "Postos de gasolina"
    case restaurants  = "Alimentação"
    case repair       = "Mecânica"
    case services     = "Postos de serviços"
    case health       = "Saúde"
    case help         = "Socorro"
    case tireShop     = "Borracharia"
    
    enum CodingKeys: String, CodingKey {
        case suport
        case hotels
        case resting
        case gas
        case restaurants
        case repair      
        case services
        case health
        case help
        case tireShop
    }
}
