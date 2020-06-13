//
//  NetworkDAO.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Data Acess Object Class for a given endpoint type
class NetworkDAO<EndPoint: EndPointType> {
    
    var router = Router<EndPoint>()
    
    public enum NetworkResponse: String {
        case sucess
        case unableToConnect     = "Please, verify your connection"
        case notFound            = "Could not find the request"
        case badRequest          = "Bad request"
        case outdated            = "The URL you requested is outdated"
        case failed              = "Network request failed"
        case noData              = "Response returned with no data to decode"
        case unableToDecode      = "We could not decode the response"
    }
    
    public enum ResponseResult<String> {
        case sucess
        case failure(String)
    }
    
    /// Evaluate a URL Response
    /// - Parameter response: The URL response returned
    /// - Returns: The Result of the evaluation
    func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult<String> {
    
        let result: ResponseResult<String>
        
        switch response.statusCode {
            
            case 200...299: result = .sucess
            case 401...500: result = .failure(NetworkResponse.notFound.rawValue)
            case 501...599: result = .failure(NetworkResponse.badRequest.rawValue)
            case 600:       result = .failure(NetworkResponse.outdated.rawValue)
            default:        result = .failure(NetworkResponse.failed.rawValue)
        }
        
        return result
    }
}
