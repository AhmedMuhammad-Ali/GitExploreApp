//
//  User.swift
//  
//
//  Created by Ahmed Ali on 28/10/2023.
//

/// A data structure representing a user.
public struct User {
    /// The unique identifier for the user.
    public var id: Int

    /// The name of the user.
    public var name: String

    /// The URL to the user's avatar.
    public var avatarUrl: String

    /// Initializes a new user.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the user.
    ///   - name: The name of the user.
    ///   - avatarUrl: The URL to the user's avatar.
    ///
    /// - Returns: A new `User` instance, or `nil` if any of the required properties is missing.
    public init?(id: Int?, name: String?, avatarUrl: String?) {
        guard let id = id, let name = name, let avatarUrl = avatarUrl else {
            return nil
        }
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
    }
}
