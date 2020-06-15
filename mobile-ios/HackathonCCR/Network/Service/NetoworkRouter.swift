//
//  NetoworkRouter.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 20/04/20.
//  Copyright © 2020 Mascarados. All rights reserved.
//

import Foundation

/// A closure block type to be executed after a request
/// - Parameters:
///   - data: The retrivied data from the request
///   - response: The response of the request
///   - error: The possible errors that may happen
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/// Protocol that definies a Network Router responsable to manage requests
public protocol NetworkRouter: AnyObject {
    
    associatedtype EndPoint = EndPointType
    
    /// Makes a request to and EndPoint
    /// - Parameters:
    ///   - route: The EndPoint of the request
    ///   - completion: The completion block to be executed after the call
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
    /// Cancel a current request
    func cancel()
}
