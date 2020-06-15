//
//  HTTPTask.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Definies a dictionary of parameters with a string key and one value
public typealias RequestParameters = [String: Any]

/// Definies a dictionary of parameters  to the headers with a string key and a string value
public typealias HTTPHeaders = [String: String]

/// Defines the types of the HTTP Tasks
public enum HTTPTask {
    
    ///Empty request
    case request
    
    ///Empty request with parameters to be inserted inside the url and/or the JSON body
    case requestWithParameters(bodyParameters: RequestParameters?, urlParameters: RequestParameters?)
    
    ///Empty request with parameters to be inserted inside the url and/or the JSON body and/or with headers
    case requestWithParametersAndHeaders(bodyParameters: RequestParameters?,
                                         urlParameters: RequestParameters?,
                                         additionalHeaders: HTTPHeaders)
}
