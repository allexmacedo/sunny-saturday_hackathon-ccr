//
//  FacilitiesServices.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation

protocol FacilitiesBusinessLogic {
    
    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], FacilitiesError>) -> Void)
}

enum FacilitiesError: String, Error {
    case notFound
}

final class FacilitiesServices: FacilitiesBusinessLogic {
    
    var facilitiesDAO: FacilitiesDataStore = FacilitiesDAO()
    
    func retriveFacilities(ofCategory category: FacilityCategory, completion: @escaping (Result<[CommercialFacility], FacilitiesError>) -> Void) {
        
        let blockForExecutionInBackground = BlockOperation {
            
            self.facilitiesDAO.retriveFacilities(ofCategory: category) { (result) in
                
                let blockForExecutionInMain = BlockOperation {
                    completion(result)
                }
                
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: .main)
            }
        }
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: .serial)
    }
}
