//
//  URLRequestConvertible.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
/// A protocol for converting an object into a URLRequest.
public protocol URLRequestConvertible {
    /// Converts the conforming object into a URLRequest.
    /// - Returns: A URLRequest representation of the conforming object, or `nil` if the conversion is not possible.
    func asURLRequest() -> URLRequest?
}
/// An extension that conforms types conforming to `Endpoint` to the `URLRequestConvertible` protocol.
extension URLRequestConvertible where Self: Endpoint {
    /// Converts the conforming `Endpoint` object into a `URLRequest`.
    ///
    /// This extension method constructs a `URLRequest` based on the properties and parameters defined in the conforming `Endpoint`.
    ///
    /// - Returns: A `URLRequest` representation of the conforming `Endpoint`, or `nil` if the conversion is not possible.
    public func asURLRequest() -> URLRequest? {
        let fullPath = baseUrl.appendingPathComponent(path)
        var urlComponents = URLComponents(url: fullPath, resolvingAgainstBaseURL: true)

        // Set query parameters if any
        if !queryParameters.isEmpty {
            urlComponents?.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }

        guard let url = urlComponents?.url else {
            return nil
        }

        // Set body data if any
        var httpBody: Data?
        if !bodyParameters.isEmpty {
            httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = httpBody

        return urlRequest
    }
}
