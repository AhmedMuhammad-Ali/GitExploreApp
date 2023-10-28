//
//  Constants.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
/// An enumeration containing constants related to network communication.
enum NetworkConstants {
    /// The base URL for network requests.
    static let baseUrl: URL = {
        guard let url = URL(string: "https://api.github.com") else {
            preconditionFailure("Invalid URL")
        }
        return url
    }()
    /// The range of HTTP status codes considered as successful responses.
    static let successCodesRage = 200...299
    /// The HTTP status code indicating unauthorized access.
    static let unauthorized = 401
}
