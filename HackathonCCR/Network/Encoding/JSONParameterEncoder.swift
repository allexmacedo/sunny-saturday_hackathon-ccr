//
//  JSONParameterEncoder.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: RequestParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        
        do {
            // Serialize the dictionary into a json object
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            // Insert on the body of the request
            urlRequest.httpBody = jsonAsData
            
            // Defines the request contet type
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw RequestEncodingError.encodingFailed
            
        }
    }
    
}
