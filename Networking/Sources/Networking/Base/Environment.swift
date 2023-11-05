//
//  Environment.swift
//  
//
//  Created by Ahmed Ali on 05/11/2023.
//

import Foundation
/// A utility for accessing environment-specific configuration from the app's Info.plist.
enum Environment {
    private enum PlistKeys {
        static let baseURL = "SERVER_URL"
        static let apiToken = "API_TOKEN"
    }
    /// Retrieve information from the app's Info.plist file.
    private static var infoDictionary: [String: Any] {
        guard let dict = Bundle.main.infoDictionary else {
            preconditionFailure("Plist file not found")
        }
        return dict
    }
    /// The base URL for the server.
    static var baseURL: URL {
        guard let rootURLString = Environment.infoDictionary[PlistKeys.baseURL] as? String else {
            preconditionFailure("Root URL not set in plist for this environment")
        }

        guard let url = URL(string: "https://\(rootURLString)") else {
            preconditionFailure("Invalid URL")
        }
        return url
    }
    /// The API token used for authentication or authorization.
    static var apiToken: String {
        guard let apiKey = Environment.infoDictionary[PlistKeys.apiToken] as? String else {
            preconditionFailure("API Key not set in plist for this environment")
        }
        return "token \(apiKey)"
    }
}
