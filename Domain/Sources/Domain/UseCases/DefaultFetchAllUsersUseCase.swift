//
//  DefaultFetchAllUsersUseCase.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

/// A concrete implementation of the `FetchAllUsersUseCase` protocol that fetches information for all users.
public final class DefaultFetchAllUsersUseCase: FetchAllUsersUseCase {
    /// The repository responsible for fetching user information.
    public let usersRepository: UsersRepository

    /// Initializes an instance of `DefaultFetchAllUsersUseCase`.
    ///
    /// - Parameter usersRepository: A repository responsible for fetching user information.
    public init(_ usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    /// Executes the use case to fetch information for all users.
    ///
    /// - Returns: An array of `User` instances representing user information.
    ///
    /// - Throws: An error of type `Error` if user information cannot be retrieved.
    public func execute() async throws -> [User] {
        try await usersRepository.fetchAllUsers()
    }
}
