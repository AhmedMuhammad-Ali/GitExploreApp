//
//  DefaultUsersRepository.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Domain
import Networking

/// A concrete implementation of the `UsersRepository` protocol for fetching user information.
public final class DefaultUsersRepository {
    private let networking: NetworkDispatcher

    /// Initializes an instance of `DefaultUsersRepository`.
    ///
    /// - Parameter networking: An optional `NetworkDispatcher` to use for network requests. Defaults to `DefaultNetworkDispatcher`.
    public init(networking: NetworkDispatcher = DefaultNetworkDispatcher()) {
        self.networking = networking
    }
}

extension DefaultUsersRepository: UsersRepository {    
    /// Fetches information for all users.
    ///
    /// - Returns: An array of `User` instances representing user information.
    ///
    /// - Throws: An error of type `Error` if user information cannot be retrieved.
    public func fetchAllUsers() async throws -> [User] {
        let result = await networking.dispatch(FetchAllUsersRequest())
        switch result {
        case .success(let responseDTO):
            return responseDTO.compactMap({ $0.toDomain() })
        case .failure(let error):
            throw error
        }
    }
}

