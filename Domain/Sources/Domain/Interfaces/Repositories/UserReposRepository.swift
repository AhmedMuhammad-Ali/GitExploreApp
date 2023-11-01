//
//  UserReposRepository.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A protocol defining the requirements for fetching a user's repositories.
public protocol UserReposRepository {
    /// Fetches all repositories owned by a given user.
    ///
    /// - Parameters:
    ///   - userName: The username for which to fetch the repositories.
    ///
    /// - Returns: An array of `Repo` instances representing the user's repositories.
    ///
    /// - Throws: An error of type `Error` if the repositories cannot be retrieved.
    func fetchAllUserRepos(by userName: String) async throws -> [Repo]
}
