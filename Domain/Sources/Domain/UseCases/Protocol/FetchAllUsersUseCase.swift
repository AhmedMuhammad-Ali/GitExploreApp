//
//  File.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

/// A protocol defining the requirements for a use case to fetch all users.
public protocol FetchAllUsersUseCase {
    /// Executes the use case to fetch all users.
    ///
    /// - Returns: An array of `User` instances representing user information.
    ///
    /// - Throws: An error of type `Error` if user information cannot be retrieved.
    func execute() async throws -> [User]

    /// A repository responsible for fetching user information.
    var usersRepository: UsersRepository { get }
}
