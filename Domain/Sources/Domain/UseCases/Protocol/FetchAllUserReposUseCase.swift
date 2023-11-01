//
//  File.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A protocol defining the requirements for a use case to fetch all repositories for a user.
public protocol FetchAllReposUseCase {
    /// Executes the use case to fetch all repositories for a user.
    ///
    /// - Parameters:
    ///   - userName: The username for which to fetch repositories.
    ///
    /// - Returns: An array of `Repo` instances representing the user's repositories.
    ///
    /// - Throws: An error of type `Error` if the repositories cannot be retrieved.
    func execute(by userName: String) async throws -> [Repo]

    /// A repository responsible for fetching user repositories.
    var reposRepository: UserReposRepository { get }
}
