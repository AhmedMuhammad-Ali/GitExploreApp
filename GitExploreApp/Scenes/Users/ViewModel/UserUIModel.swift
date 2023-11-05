//
//  UserUIModel.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 30/10/2023.
//

import Domain

/// A model representing a GitHub user's information.
struct UserUIModel: Identifiable {

    /// The unique identifier for the user.
    var id: Int = .zero

    /// The name of the GitHub user.
    var userName: String = .empty

    /// The avatar URL of the GitHub user.
    var userAvatar: String = .empty

    /// The count of repositories owned by the user.
    var formattedReposCount: String {
        "\(repos.count) Repositories"
    }

    /// The count of followers of the user.
    var followersCount: String = .empty

    /// The formatted count of followers.
    var formattedFollowersCount: String {
        "\(followersCount) Followers"
    }

    /// The list of repositories owned by the user.
    var repos: [Repo] = []
}

extension UserUIModel {

    /// Initializes a `UserUIModel` from a `User`, a collection of repositories, and a followers count.
    /// - Parameters:
    ///   - user: The user's information.
    ///   - repos: The list of repositories owned by the user.
    ///   - followersCount: The count of followers for the user.
    init(from user: User, repos: Repos, followersCount: Int) {
        self.id = user.id
        self.userName = user.name
        self.userAvatar = user.avatarUrl
        self.repos = repos
        self.followersCount = "\(followersCount)"
    }
}
