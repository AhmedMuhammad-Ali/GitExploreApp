//
//  FetchAllFollowersUseCase.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A protocol defining the requirements for a use case to fetch a user's followers count.
public protocol FetchUserFollowersCountUseCase {
    /// Executes the use case to fetch the followers count for a user.
    ///
    /// - Parameter userName: The username for which to fetch the followers count.
    ///
    /// - Returns: The number of followers for the specified user.
    ///
    /// - Throws: An error of type `Error` if the followers count cannot be retrieved.
    func callAsFunction(for userName: String) async throws -> Int

    /// A repository responsible for fetching followers count.
    var followersRepository: FollowersRepository { get }
}
