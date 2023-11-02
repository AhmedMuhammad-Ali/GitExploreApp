//
//  DefaultFetchAllForkedUserUseCase.swift
//  
//
//  Created by Ahmed Ali on 02/11/2023.
//

/// A concrete implementation of the `FetchAllForkedUserUseCase` protocol for fetching forked users of a specific repository.
public final class DefaultFetchAllForkedUserUseCase: FetchAllForkedUserUseCase {
    /// The repository responsible for fetching forked users' data.
    public var forkedUsersRepository: ForkedUsersRepository

    /// Initializes an instance of `DefaultFetchAllForkedUserUseCase`.
    ///
    /// - Parameter forkedUsersRepository: The repository for fetching forked user data.
    public init(forkedUsersRepository: ForkedUsersRepository) {
        self.forkedUsersRepository = forkedUsersRepository
    }

    /// Executes the use case to fetch forked users for a specified repository owned by a user.
    ///
    /// - Parameters:
    ///   - userName: The username of the repository's owner.
    ///   - repository: The name of the repository.
    ///
    /// - Returns: An array of `User` instances representing users who have forked the repository.
    ///
    /// - Throws: An error of type `Error` if the forked users cannot be retrieved.
    public func execute(byOwner userName: String, for repository: String) async throws -> [User] {
        try await forkedUsersRepository.fetchAllForkedUsers(byOwner: userName, for: repository)
    }
}
