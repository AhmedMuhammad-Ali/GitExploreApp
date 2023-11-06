//
//  UserUIModel.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 30/10/2023.
//

import Domain

/// A model representing a GitHub user's information.
struct UserUIModel {

    /// The unique identifier for the user.
    var id: Int = .zero

    /// The name of the GitHub user.
    var userName: String = .empty

    /// The avatar URL of the GitHub user.
    var userAvatar: String = .empty

    /// The count of followers of the user.
    var followersCount: String = .notAvailable

    /// The count of repos of the user.
    var reposCount: String = .notAvailable

    /// The formatted count of followers.
    var formattedFollowersCount: String {
        (followersCount == .notAvailable ? followersCount : "\(followersCount)") + " Followers"
    }
    /// The count of repositories owned by the user.
    var formattedReposCount: String {
        (reposCount == .notAvailable ? reposCount : "\(reposCount)") + " Repositories"
    }
    /// The list of repositories owned by the user.
    var repos: [Repo] = []
}

extension UserUIModel {

    /// Initializes a `UserUIModel` from a `User`, a collection of repositories, and a followers count.
    /// - Parameters:
    ///   - user: The user's information.
    ///   - repos: The list of repositories owned by the user.
    ///   - reposCount: The count of repositories for the user.
    ///   - followersCount: The count of followers for the user.
    init(from user: User,
         repos: Repos,
         reposCount: String,
         followersCount: String) {
        self.id = user.id
        self.userName = user.name
        self.userAvatar = user.avatarUrl
        self.repos = repos
        self.followersCount = followersCount
        self.reposCount = reposCount
    }
}
