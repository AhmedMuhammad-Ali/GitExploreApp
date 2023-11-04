//
//  UserResponse+Mapping.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

import Domain

/// A data transfer object (DTO) representing user response data.
struct UsersResponseDTO: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?

    /// Coding keys to map the DTO fields to JSON keys.
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
// MARK: - Mappings to Domain
extension UsersResponseDTO {
    /// Converts the DTO to a domain model.
    func toDomain() -> User? {
        return .init(id: id, name: login, avatarUrl: avatarURL)
    }
}
