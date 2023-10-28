//
//  NetworkDispatcher.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
// MARK: - RequestType
/// A type-alias that combines the `TargetType` and `ResponseDecoder` protocols.
public typealias RequestType = Endpoint & ResponseDecoder

/// A protocol for dispatching network requests.
public protocol NetworkDispatcher {
    /// Dispatches an asynchronous network request and returns a Result object indicating the success or failure of the request.
    /// - Parameters:
    ///   - request: The request object conforming to the RequestType protocol.
    /// - Returns: An asynchronous Result object containing either a success value of type `Request.ResponseType` or a failure value of type `RequestError`..
    func dispatch<Request: RequestType>(_ request: Request) async -> Result<Request.ResponseType, RequestError>
}


