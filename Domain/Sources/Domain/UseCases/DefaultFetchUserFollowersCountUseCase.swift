//
//  DefaultFetchAllFollowersUseCase.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

import Foundation

/// A concrete implementation of the `FetchUserFollowersCountUseCase` protocol that fetches a user's followers count.
public final class DefaultFetchUserFollowersCountUseCase: FetchUserFollowersCountUseCase {
    /// The repository responsible for fetching followers count.
    public let followersRepository: FollowersRepository

    /// Initializes an instance of `DefaultFetchUserFollowersCountUseCase`.
    ///
    /// - Parameter followersRepository: A repository responsible for fetching followers count.
    public init(_ followersRepository: FollowersRepository) {
        self.followersRepository = followersRepository
    }

    /// Executes the use case to fetch a user's followers count.
    ///
    /// - Parameter userName: The username for which to fetch the followers count.
    ///
    /// - Returns: The number of followers for the specified user.
    ///
    /// - Throws: An error of type `Error` if the followers count cannot be retrieved.
    public func callAsFunction(for userName: String) async throws -> Int {
        try await followersRepository.fetchFollowersCount(for: userName)
    }
}
