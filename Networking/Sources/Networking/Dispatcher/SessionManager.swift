//
//  SessionManager.swift
//  
//
//  Created by Ahmed Ali on 05/11/2023.
//

import Foundation
/// A manager responsible for managing URLSession instances with custom configurations.
class SessionManager {
    /// The shared instance of the SessionManager.
    static let shared = SessionManager()
    private init() { }
    /// The URLSession instance with default configuration.
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }()
    /// Configures the URLSession with custom URL protocols.
    /// - Parameter protocols: An array of URLProtocol types to use for the URLSession.
    func configure(protocols: [URLProtocol.Type]) {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = protocols
        session = URLSession(configuration: configuration)
    }
}
