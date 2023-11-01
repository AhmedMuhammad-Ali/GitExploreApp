//
//  FetchAllUsersRequest.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Networking

/// A request for fetching all users.
struct FetchAllUsersRequest: RequestType {
    typealias ResponseType = [UsersResponseDTO]
    
    /// The path for the request, indicating all users.
    var path: String {
        "/users"
    }
    
    /// The HTTP method for the request.
    var method: Networking.RequestMethod {
        .get
    }
}

