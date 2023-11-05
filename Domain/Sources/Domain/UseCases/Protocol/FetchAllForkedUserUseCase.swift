//
//  FetchAllForkedUserUseCase.swift
//  
//
//  Created by Ahmed Ali on 02/11/2023.
//

/// A use case protocol for fetching all users who have forked a specific repository.
public protocol FetchAllForkedUserUseCase {
    /// Executes the use case to fetch forked users for a given repository owned by a user.
    ///
    /// - Parameters:
    ///   - userName: The username of the repository's owner.
    ///   - repository: The name of the repository.
    ///
    /// - Returns: An array of `User` instances representing users who have forked the repository.
    ///
    /// - Throws: An error of type `Error` if the forked users cannot be retrieved.
    func execute(byOwner userName: String, for repository: String) async throws -> [User]

    /// The repository responsible for fetching forked users' data.
    var forkedUsersRepository: ForkedUsersRepository { get }
}
