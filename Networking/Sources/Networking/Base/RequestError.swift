//
//  RequestError.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//
/// An enumeration representing common errors that can occur during network requests.
public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
