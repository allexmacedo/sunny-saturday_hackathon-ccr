//
//  URLParameterEncoder.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Struct responsable to insert URL Parameters into a URLRequest
public struct URLParameterEncoder: RequestParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: RequestParameters) throws {
        
        // Verfiies if there is an URL
        guard let url = urlRequest.url else {throw RequestEncodingError.missingURL}
        
        // Create the components of the URL
        if var components = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            components.queryItems = [URLQueryItem]()
            
            // Insert each parameter
            for (key, value) in parameters {
                
                let formattedValue: Any
                
                if let string = value as? String {
                    formattedValue = string.forSorting
                } else {
                    formattedValue = value
                }
                
                let queryItem = URLQueryItem(name: key,
                                             value: "\(formattedValue)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                
                components.queryItems?.append(queryItem)
            }
            
            urlRequest.url = components.url
            
        }
        
        // Defines the content type
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
