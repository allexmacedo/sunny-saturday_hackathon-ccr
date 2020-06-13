//
//  EndPointType.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Protocol that defines a EndPoint
public protocol EndPointType {
    
    /// The main URL of the request
    /// - E.g: www.api.com
    var baseURL: String {get}
    
    /// The path of the endpoint inside the URL
    /// - A full URL:  www.api.com/users becomes a Path: /users
    var path: String {get}
    
    /// The HTTP Method of the request
    var httpMethod: HTTPMethod {get}
    
    /// The Task Parameters of the request, url parameters and/or body parameters
    var task: HTTPTask {get}
    
    /// The headers of the request
    var headers: HTTPHeaders? {get}
}
