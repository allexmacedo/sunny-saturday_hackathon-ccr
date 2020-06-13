//
//  HTTPMethod.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Describes the kind of HTTP requests avaliable
public enum HTTPMethod: String {
    
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
