//
//  FetchAllFollowersRequest.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

import Networking

/// A request for fetching all followers of a user.
struct FetchAllFollowersRequest: RequestType {
    typealias ResponseType = [UsersResponseDTO]
    
    /// The username for which to fetch followers.
    private let userName: String
    
    /// Initializes an instance of `FetchAllFollowersRequest`.
    ///
    /// - Parameter userName: The username for which to fetch followers.
    init(userName: String) {
        self.userName = userName
    }
    
    /// The path for the request.
    var path: String {
        "users/\(userName)/followers"
    }
    
    /// The HTTP method for the request.
    var method: Networking.RequestMethod {
        .get
    }
}
