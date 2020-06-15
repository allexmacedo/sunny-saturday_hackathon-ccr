//
//  CategoryAPI.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import Foundation

enum FacilityAPI: EndPointType {
    case allCategories
    
    var baseURL: String {
        return "https://sunny-saturday-app.herokuapp.com/"
    }
    
    var path: String {
        return "categories"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
