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

    /// The full name of the repository, including the user or organization that owns it.
    public let fullName: String?

    /// The user or organization that owns the repository.
    public let owner: User?

    /// The licensing information for the repository.
    public let license: License?

    /// The URL to access the forks of this repository.
    public let forksURL: String?

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
                fullName: String?,
                owner: User?,
                license: License?,
                forksURL: String?) {
        self.name = name
        self.description = description
        self.fullName = fullName
        self.owner = owner
        self.license = license
        self.forksURL = forksURL
    }
}

/// A data structure representing licensing information for a repository.
public struct License {
    /// The name of the license.
    public let name: String?

    /// Initializes a new license with the given name.
    /// - Parameter name: The name of the license.
    public init(name: String?) {
        self.name = name
    }
}
