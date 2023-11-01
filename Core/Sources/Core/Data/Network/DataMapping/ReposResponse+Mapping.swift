//
//  File.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//
import Domain

/// A data transfer object (DTO) representing a response for repositories.
struct ReposResponseDTO: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let fullName: String?
    let owner: UsersResponseDTO?
    let license: LicenseResponseDTO?
    let forksURL: String?
    /// Coding keys to map the DTO fields to JSON keys.
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case owner, license
        case fullName = "full_name"
        case forksURL = "forks_url"
    }
}
/// A data transfer object (DTO) representing licensing information.
struct LicenseResponseDTO: Codable {
    let key: String?
    let name: String?
    let spdxID: String?
    let url: String?
    let nodeID: String?

    /// Coding keys to map the DTO fields to JSON keys.
    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
/// Extension to convert the DTO to a corresponding domain model.
extension ReposResponseDTO {
    /// Converts the DTO to a domain model, or returns nil if certain fields are missing.
    func toDomain() -> Repo? {
        guard let name = name else { return nil }
        return .init(name: name,
                     description: description,
                     fullName: fullName,
                     owner: owner?.toDomain(),
                     license: License(name: license?.name),
                     forksURL: forksURL)
    }
}
