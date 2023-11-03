//
//  ForkedUsersResponseDTO.swift
//  
//
//  Created by Ahmed Ali on 03/11/2023.
//

import Foundation
/// A data transfer object (DTO) representing forked user response data.
struct ForkedUsersResponseDTO: Codable {
    let owner: UsersResponseDTO?
}
