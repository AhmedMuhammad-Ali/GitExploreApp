//
//  Endpoint.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
/// A protocol representing a network request.
public protocol Endpoint: URLRequestConvertible {
    /// The base URL of the request.
    var baseUrl: URL { get }

    /// The path component of the request URL.
    var path: String { get }

    /// The HTTP method of the request.
    var method: RequestMethod { get }

    /// The query parameters of the request.
    var queryParameters: [String: String] { get }

    /// The body parameters of the request.
    var bodyParameters: [String: Any] { get }

    /// The headers of the request.
    var headers: [String: String] { get }
}

extension Endpoint {
    /// Default implementation of headers.
    public var baseUrl: URL {
        Environment.baseURL
    }
    /// A dictionary of HTTP headers, including an "Authorization" header with the API token.
    public var headers: [String: String] {
        ["Authorization": Environment.apiToken]
    }
    /// Default implementation of query parameters.
    public var queryParameters: [String: String] { [:] }

    /// Default implementation of body parameters.
    public var bodyParameters: [String: Any] { [:] }
}
