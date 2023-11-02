//
//  ForkedUsersRepository.swift
//  
//
//  Created by Ahmed Ali on 02/11/2023.
//

/// A protocol for fetching users who forked a specific repository.
public protocol ForkedUsersRepository {
    /// Fetches all users who have forked a particular repository for a specified user.
    ///
    /// - Parameters:
    ///   - userName: The username of the repository's owner.
    ///   - repository: The name of the repository.
    ///
    /// - Returns: An array of `User` instances representing users who have forked the repository.
    ///
    /// - Throws: An error of type `Error` if the forked users cannot be retrieved.
    func fetchAllForkedUsers(byOwner userName: String, for repository: String) async throws -> [User]
}
