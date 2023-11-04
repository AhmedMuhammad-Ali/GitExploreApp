//
//  DefaultNetworkDispatcher.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Foundation
/// The default implementation of the NetworkDispatcher protocol.
public final class DefaultNetworkDispatcher: NetworkDispatcher {

    /// Initializes the DefaultNetworkDispatcher with an optional URLSession instance.
    public init() {}
    public func dispatch<Request: RequestType>(_ request: Request) async -> Result<Request.ResponseType, RequestError> {
        guard let urlRequest = request.asURLRequest() else {
            return .failure(.invalidURL)
        }
        do {
            let (data, response) = try await SessionManager.shared.session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            return checkStatusCode(response, request, data)
        } catch {
            return .failure(.unknown)
        }
    }
}
// MARK: - DefaultNetworkDispatcher + Status Code Check
private extension DefaultNetworkDispatcher {
    ///  Checks the status code of an HTTP response and returns a result indicating success or failure.
    /// - Parameters:
    ///   - response: The HTTPURLResponse object received from the network request.
    ///   - request: The request object conforming to the RequestType protocol, used for decoding the response data.
    ///   - data: The response data received from the network request.
    /// - Returns: A Result object containing either a success value of type `Request.ResponseType` or a failure value of type `RequestError`.
    func checkStatusCode<Request: RequestType>(_ response: HTTPURLResponse,
                                               _ request: Request,
                                               _ data: Data) -> Result<Request.ResponseType, RequestError> {
        switch response.statusCode {
        case NetworkConstants.successCodesRage:
            guard let decodedResponse = try? request.responseDecoder(data) else {
                return .failure(.decode)
            }
            return .success(decodedResponse)
        case NetworkConstants.unauthorized:
            return .failure(.unauthorized)
        default:
            return .failure(.unexpectedStatusCode)
        }
    }
}
