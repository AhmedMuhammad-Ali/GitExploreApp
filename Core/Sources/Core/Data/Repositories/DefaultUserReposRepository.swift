//
//  DefaultUserReposRepository.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

import Domain
import Networking

/// A concrete implementation of the `UserReposRepository` protocol for fetching a user's repositories.
public final class DefaultUserReposRepository {
    private let networking: NetworkDispatcher

    /// Initializes an instance of `DefaultUserReposRepository`.
    ///
    /// - Parameter networking: An optional `NetworkDispatcher` to use for network requests. Defaults to `DefaultNetworkDispatcher`.
    public init(networking: NetworkDispatcher = DefaultNetworkDispatcher()) {
        self.networking = networking
    }
}
// MARK: - DefaultUserReposRepository + UserReposRepository
extension DefaultUserReposRepository: UserReposRepository {
    /// Fetches all repositories owned by a specified user.
    ///
    /// - Parameter userName: The username for which to fetch the repositories.
    ///
    /// - Returns: An array of `Repo` instances representing the user's repositories.
    ///
    /// - Throws: An error of type `Error` if the repositories cannot be retrieved.
    public func fetchAllUserRepos(by userName: String) async throws -> [Repo] {
        let result = await networking.dispatch(FetchAllReposRequest(userName: userName))
        switch result {
        case .success(let responseDTO):
            return responseDTO.compactMap { $0.toDomain() }
        case .failure(let error):
            throw error
        }
    }
}
