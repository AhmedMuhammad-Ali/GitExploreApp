//
//  ForkedUsersViewModel+Dependency.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 04/11/2023.
//
import Domain

// MARK: - ForkedUsersViewModel+Dependency
extension ForkedUsersViewModel {
    /// A structure containing context details for the Forked Users View Model.
    struct ForkedUserContextDetails {
        /// The GitHub user's username.
        let userName: String
        /// The name of the repository.
        let repoName: String

        /// Initializes a context with the specified user and repository names.
        /// - Parameters:
        ///   - userName: The GitHub user's username.
        ///   - repoName: The name of the repository.
        init(userName: String, repoName: String) {
            self.userName = userName
            self.repoName = repoName
        }
    }
}
/// A view model representing a forked GitHub user.
struct ForkedUserViewModel {
    /// The unique identifier for the user.
    var id: Int = .zero
    /// The name of the GitHub user.
    var userName: String = .empty
    /// The avatar of the GitHub user.
    var userAvatar: String = .empty

    /// Initializes a `ForkedUserViewModel` from a user entity.
    /// - Parameter user: The user entity to create the view model from.
    init(from user: User) {
        self.id = user.id
        self.userName = user.name
        self.userAvatar = user.avatarUrl
    }
}
