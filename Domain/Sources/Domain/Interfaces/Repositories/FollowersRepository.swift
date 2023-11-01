//
//  FollowersRepository.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A protocol defining the requirements for fetching a user's followers count.
public protocol FollowersRepository {
    /// Fetches the number of followers for a given user.
    ///
    /// - Parameters:
    ///   - userName: The username for which to fetch the followers count.
    ///
    /// - Returns: The number of followers for the specified user.
    ///
    /// - Throws: An error of type `Error` if the followers count cannot be retrieved.
    func fetchFollowersCount(for userName: String) async throws -> Int
}
