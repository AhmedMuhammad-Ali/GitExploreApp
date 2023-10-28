//
//  ResponseDecoder.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

// MARK: - ResponseDecoder
import Foundation
/// A protocol for handling the decoding of network response data into a specific response type.
public protocol ResponseDecoder {
    /// The type of the response expected from the request.
    associatedtype ResponseType: Decodable

    /// A closure that handles the decoding of the response data.
    ///
    /// - Parameters:
    ///   - data: The raw data obtained from the network response.
    /// - Returns: An instance of the `ResponseType` after successfully decoding the provided data.
    /// - Throws: An error if decoding fails, typically due to malformed or incompatible data.
    var responseDecoder: (Data) throws -> ResponseType { get }
}

extension ResponseDecoder {
    /// Default implementation of responseDecoder that uses JSONDecoder to decode the response data.
    public var responseDecoder: (Data) throws -> ResponseType {
        { data in
            let decoder = JSONDecoder()
            return try decoder.decode(ResponseType.self, from: data)
        }
    }
}
