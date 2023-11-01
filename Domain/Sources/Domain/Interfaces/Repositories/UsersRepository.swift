//
//  UsersRepository.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

/// A protocol defining the requirements for fetching user information.
public protocol UsersRepository {
    /// Fetches information for all users.
    ///
    /// - Returns: An array of `User` instances representing user information.
    ///
    /// - Throws: An error of type `Error` if the user information cannot be retrieved.
    func fetchAllUsers() async throws -> [User]
}
