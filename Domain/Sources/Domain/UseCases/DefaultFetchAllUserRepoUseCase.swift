//
//  DefaultFetchAllUserRepoUseCase.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A concrete implementation of the `FetchAllReposUseCase` protocol that fetches all repositories for a user.
public final class DefaultFetchAllUserRepoUseCase: FetchAllReposUseCase {
    /// The repository responsible for fetching user repositories.
    public let reposRepository: UserReposRepository

    /// Initializes an instance of `DefaultFetchAllUserRepoUseCase`.
    ///
    /// - Parameter reposRepository: A repository responsible for fetching user repositories.
    public init(_ reposRepository: UserReposRepository) {
        self.reposRepository = reposRepository
    }

    /// Executes the use case to fetch all repositories for a user.
    ///
    /// - Parameter userName: The username for which to fetch repositories.
    ///
    /// - Returns: An array of `Repo` instances representing the user's repositories.
    ///
    /// - Throws: An error of type `Error` if the repositories cannot be retrieved.
    public func execute(by userName: String) async throws -> [Repo] {
        try await reposRepository.fetchAllUserRepos(by: userName)
    }
}
