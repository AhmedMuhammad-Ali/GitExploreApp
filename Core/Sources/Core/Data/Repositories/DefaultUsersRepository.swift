//
//  DefaultUsersRepository.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Domain
import Networking
import Storage

/// A concrete implementation of the `UsersRepository` protocol for fetching user information.
public final class DefaultUsersRepository {
    private let networking: NetworkDispatcher
    private let storage: UserStorage
    /// Initializes an instance of `DefaultUsersRepository`.
    ///
    /// - Parameter networking: An optional `NetworkDispatcher` to use for network requests. Defaults to `DefaultNetworkDispatcher`.
    /// - Parameter storage: An optional `UserStorage` to use for storage requests. Defaults to `DefaultUserStorage`.
    public init(networking: NetworkDispatcher = DefaultNetworkDispatcher(),
                storage: UserStorage = DefaultUserStorage()) {
        self.networking = networking
        self.storage = storage
    }
}
// MARK: - DefaultUsersRepository + UsersRepository
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
            return saveAndReturnUsers(responseDTO)
        case .failure(let error):
            if error == .noInternetConnection {
                return storage.fetchAllUsers()
            } else {
                throw error
            }
        }
    }
    /// Save and return an array of User objects from a response DTO.
    ///
    /// - Parameter responseDTO: The response DTO (Data Transfer Object) containing user data.
    /// - Returns: An array of User objects extracted from the response DTO after saving them to storage.
    private func saveAndReturnUsers(_ responseDTO: (FetchAllUsersRequest.ResponseType)) -> [User] {
        return responseDTO.compactMap {
            if let user = $0.toDomain() {
                storage.saveUser(user)
            }
            return $0.toDomain()
        }
    }
}
