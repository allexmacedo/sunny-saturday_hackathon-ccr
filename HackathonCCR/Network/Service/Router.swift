//
//  Router.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// Class responsable to create and execute complete URL Request from a given EndPoint Type
final class Router<EndPoint: EndPointType>: NetworkRouter {
    
    /// URLTask responsable to make the URLRequest
    private var task: URLSessionTask?
    
    /// If the object is dealocated, cancel the request
    deinit {
        self.cancel()
    }
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        
        do {
            
            // Creates the request
            let request = try self.buildRequest(from: route)
            
            // Attribute the request to the URL Task in order to be executed
            task = session.dataTask(with: request, completionHandler: completion)
            
        } catch {
            completion(nil, nil, error)
        }
        
        // Run the task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    /// Build a request of a EndPoint
    /// - Parameter route: The reuqest EndPoint
    /// - Throws: Errors that may occur during the url encoding or the body encoding
    /// - Returns: URLResquest ready to be run according to the given parameters
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        // Creates the Resquest
        // Joins baseURL + path
        // Removes possible cache on the device or the network in order to retrive always the updated data
        // Maximum time request = 10s
        
        guard let routeURL = URL(string: route.baseURL) else {throw RequestEncodingError.invalidURL}
        
        var request = URLRequest(url: routeURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            
            // Encode the parameters and insert into the request
            
            switch route.task {
                
                case .request:
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                case .requestWithParameters(let bodyParameters, let urlParameters):
                    
                    try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
                case .requestWithParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                    
                    self.configureHeaders(headers: additionalHeaders, request: &request)
                    
                    try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            
            return request
            
        } catch {
            throw error
        }
    }
    
    /// Insert a RequestParameters inside an URLRequest
    /// - Parameters:
    ///   - bodyParameters: Parameters to be inserted on the body JSON
    ///   - urlParameters: Parameters to be inserted on the URL
    ///   - request: The URLResquest that the parameters should be inserted
    /// - Throws: Encoding Errors that may occur
    private func configureParameters(bodyParameters: RequestParameters?,
                                     urlParameters: RequestParameters?,
                                     request: inout URLRequest) throws {
        
        do {
            
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
            
        } catch {
            throw error
        }
    }
    
    /// Insert HTTP Headers inside an URLRequest
    /// - Parameters:
    ///   - headers: Parameters to be inserted on the URL Headers
    ///   - request: The URLResquest that the parameters should be inserted
    private func configureHeaders(headers: HTTPHeaders?, request: inout URLRequest) {
        
        guard let headers = headers else {return}
        
        for(key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
