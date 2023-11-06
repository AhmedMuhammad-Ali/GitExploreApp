//
//  RequestError.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
/// `RequestError` is an enumeration representing various errors that can occur during network requests.
public enum RequestError: Error, LocalizedError {
    /// Error indicating a decoding failure during response handling.
    case decode

    /// Error indicating an invalid URL.
    case invalidURL

    /// Error indicating no response received from the server.
    case noResponse

    /// Error indicating unauthorized access or a session expiration.
    case unauthorized

    /// Error indicating an unexpected status code in the response.
    case unexpectedStatusCode

    /// Error indicating no internet connection available.
    case noInternetConnection

    /// Error indicating an unknown or unspecified error.
    case unknown

    /// Localized error description for each error case.
    public var errorDescription: String? {
        switch self {
        case .decode:
            return NSLocalizedString("Decode error", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .noResponse:
            return NSLocalizedString("No response from the server", comment: "")
        case .unauthorized:
            return NSLocalizedString("Session expired", comment: "")
        case .unexpectedStatusCode:
            return NSLocalizedString("Unexpected status code received", comment: "")
        case .noInternetConnection:
            return NSLocalizedString("No internet connection. Please check your Wi-Fi or mobile data connection and try again.", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
