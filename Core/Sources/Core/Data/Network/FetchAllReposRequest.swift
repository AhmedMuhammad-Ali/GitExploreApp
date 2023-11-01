//
//  FetchAllReposRequest.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

import Networking

/// A request for fetching all repositories of a user.
struct FetchAllReposRequest: RequestType {
    typealias ResponseType = [ReposResponseDTO]
    
    /// The username for which to fetch repositories.
    private let userName: String
    
    /// Initializes an instance of `FetchAllReposRequest`.
    ///
    /// - Parameter userName: The username for which to fetch repositories.
    init(userName: String) {
        self.userName = userName
    }
    
    /// The path for the request.
    var path: String {
        "users/\(userName)/repos"
    }
    
    /// The HTTP method for the request.
    var method: Networking.RequestMethod {
        .get
    }
}

