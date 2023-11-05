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
    let owner: UsersResponseDTO?
    let license: LicenseResponseDTO?
}
/// A data transfer object (DTO) representing licensing information.
struct LicenseResponseDTO: Codable {
    let name: String?
}
/// Extension to convert the DTO to a corresponding domain model.
extension ReposResponseDTO {
    /// Converts the DTO to a domain model, or returns nil if certain fields are missing.
    func toDomain() -> Repo? {
        guard let name = name else { return nil }
        return .init(name: name,
                     description: description,
                     owner: owner?.toDomain(),
                     license: license?.name)
    }
}
