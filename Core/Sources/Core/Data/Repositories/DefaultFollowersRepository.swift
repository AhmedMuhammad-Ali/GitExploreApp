//
//  DefaultFollowersRepository.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//
import Domain
import Networking

/// A concrete implementation of the `FollowersRepository` protocol for fetching followers' data.
public final class DefaultFollowersRepository: FollowersRepository {
    private let networking: NetworkDispatcher

    /// Initializes an instance of `DefaultFollowersRepository`.
    ///
    /// - Parameter networking: An optional `NetworkDispatcher` to use for network requests. Defaults to `DefaultNetworkDispatcher`.
    public init(networking: NetworkDispatcher = DefaultNetworkDispatcher()) {
        self.networking = networking
    }
}

extension DefaultFollowersRepository {
    /// Fetches the count of followers for a specified user.
    ///
    /// - Parameter userName: The username for which to fetch the followers count.
    ///
    /// - Returns: The number of followers for the specified user.
    ///
    /// - Throws: An error of type `Error` if the followers count cannot be retrieved.
    public func fetchFollowersCount(for userName: String) async throws -> Int {
        let result = await networking.dispatch(FetchAllFollowersRequest(userName: userName))
        switch result {
        case .success(let responseDTO):
            return responseDTO.count
        case .failure(let error):
            throw error
        }
    }
}
