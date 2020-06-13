//
//  ParameterEncoding.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Protocol that defines a class capable of creating a URLRequest based on given parameters
public protocol RequestParameterEncoder {
    
    /// Encode Parameters inside the URL Request
    /// - Parameters:
    ///   - urlRequest: The request that the encoded parameters should be iserted
    ///   - parameters: The parameters that should be iserted in the request
    static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws
}

public enum RequestEncodingError: String, Error {
    case parameterNil   = "Parameters where Nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL     = "URL is nil"
    case invalidURL     = "The current URL is invalid"
}
