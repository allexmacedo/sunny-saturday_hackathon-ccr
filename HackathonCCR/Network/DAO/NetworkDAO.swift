//
//  NetworkDAO.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Data Acess Object Class for a given endpoint type
class NetworkDAO<EndPoint: EndPointType> {
    
    var router = Router<EndPoint>()
    
    public enum NetworkResponseError: String, Error {
        case sucess
        case unableToConnect     = "Please, verify your connection"
        case notFound            = "Could not find the request"
        case badRequest          = "Bad request"
        case outdated            = "The URL you requested is outdated"
        case failed              = "Network request failed"
        case noData              = "Response returned with no data to decode"
        case unableToDecode      = "We could not decode the response"
    }
    
    public enum ResponseResult<NetworkResponseError> {
        case sucess
        case failure(NetworkResponseError)
    }
    
    /// Evaluate a URL Response
    /// - Parameter response: The URL response returned
    /// - Returns: The Result of the evaluation
    func handleNetworkResponse(_ response: HTTPURLResponse) -> ResponseResult<NetworkResponseError> {
    
        let result: ResponseResult<NetworkResponseError>
        
        switch response.statusCode {
            
            case 200...299: result = .sucess
            case 401...500: result = .failure(NetworkResponseError.notFound)
            case 501...599: result = .failure(NetworkResponseError.badRequest)
            case 600:       result = .failure(NetworkResponseError.outdated)
            default:        result = .failure(NetworkResponseError.failed)
        }
        
        return result
    }
}
