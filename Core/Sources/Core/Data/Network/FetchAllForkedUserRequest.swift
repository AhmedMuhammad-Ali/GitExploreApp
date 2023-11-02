//
//  FetchAllForkedUserRequest.swift
//  
//
//  Created by Ahmed Ali on 02/11/2023.
//

import Networking

/// A request for fetching all users who have forked a specific repository.
struct FetchAllForkedUserRequest: RequestType {

    typealias ResponseType = [UsersResponseDTO]

    /// The username of the repository's owner.
    private let userName: String
    /// The name of the repository.
    private let repoName: String

    /// Initializes an instance of `FetchAllForkedUserRequest`.
    ///
    /// - Parameters:
    ///   - userName: The username of the repository's owner.
    ///   - repoName: The name of the repository.
    init(userName: String, repoName: String) {
        self.userName = userName
        self.repoName = repoName
    }

    /// The path for the request to fetch forked users.
    var path: String {
        "repos/\(userName)/\(repoName)/repos"
    }

    /// The HTTP method for the request.
    var method: Networking.RequestMethod {
        .get
    }
}
