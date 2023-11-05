//
//  File.swift
//  
//
//  Created by Ahmed Ali on 29/10/2023.
//

/// A data structure representing a software repository.
public struct Repo {
    /// The name of the repository.
    public let name: String

    /// A short description of the repository.
    public let description: String?

    /// The user or organization that owns the repository.
    public let owner: User?

    /// The licensing information for the repository.
    public let license: String?

    /// Initializes a new repository.
    /// - Parameters:
    ///   - name: The name of the repository.
    ///   - description: A short description of the repository.
    ///   - fullName: The full name of the repository, including the owner.
    ///   - owner: The user or organization that owns the repository.
    ///   - license: The licensing information for the repository.
    ///   - forksURL: The URL to access the forks of this repository.
    public init(name: String,
                description: String?,
                owner: User?,
                license: String?) {
        self.name = name
        self.description = description
        self.owner = owner
        self.license = license
    }
}
