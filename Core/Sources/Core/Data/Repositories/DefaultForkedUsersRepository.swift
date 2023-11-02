//
//  Default.swift
//  
//
//  Created by Ahmed Ali on 02/11/2023.
//

import Domain
import Networking

/// A repository for fetching users who have forked specific repositories.
public final class DefaultForkedUsersRepository {
    private let networking: NetworkDispatcher

    /// Initializes an instance of `DefaultForkedUsersRepository`.
    ///
    /// - Parameter networking: An optional `NetworkDispatcher` to use for network requests. Defaults to `DefaultNetworkDispatcher`.
    public init(networking: NetworkDispatcher = DefaultNetworkDispatcher()) {
        self.networking = networking
    }
}

// MARK: - DefaultForkedUsersRepository + ForkedUsersRepository
extension DefaultForkedUsersRepository: ForkedUsersRepository {
    /// Fetches all users who have forked a specific repository owned by a user.
    ///
    /// - Parameters:
    ///   - userName: The username of the repository's owner.
    ///   - repository: The name of the repository.
    ///
    /// - Returns: An array of `User` instances representing users who have forked the repository.
    ///
    /// - Throws: An error of type `Error` if the forked users cannot be retrieved.
    public func fetchAllForkedUsers(byOwner userName: String, for repository: String) async throws -> [User] {
        let result = await networking.dispatch(FetchAllForkedUserRequest(userName: userName,
                                                                         repoName: repository))
        switch result {
        case .success(let responseDTO):
            return responseDTO.compactMap { $0.toDomain() }
        case .failure(let error):
            throw error
        }
    }
}
