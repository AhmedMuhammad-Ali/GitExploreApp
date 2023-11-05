//
//  UserEntity.swift
//  
//
//  Created by Ahmed Ali on 05/11/2023.
//

import CoreData
import Domain
/// UserEntity represents a CoreData entity for storing user-related data.
@objc(UserEntity)
final class UserEntity: NSManagedObject, Object {
    /// A static method to create a fetch request for UserEntity.
    ///
    /// - Returns: An `NSFetchRequest` for `UserEntity`.
    public static func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest(entityName: "UserEntity")
    }
    /// Managed property for storing the user's ID.
    @NSManaged var userId: Int64

    /// Managed property for storing the user's name.
    @NSManaged var userName: String

    /// Managed property for storing the user's avatar URL. It can be optional.
    @NSManaged var userAvatarUrl: String?
}
/// Converts the `UserEntity` object to a `User` object in the Domain layer.
///
/// This method maps the properties of `UserEntity` to `User`. If the user's ID is a valid integer, it creates a `User` instance with the corresponding values.
///
/// - Returns: A `User` object if the conversion is successful; otherwise, nil.
extension UserEntity {
    func toDomain() -> User? {
        if let id = Int(exactly: self.userId) {
            return User(id: id, name: userName, avatarUrl: userAvatarUrl)
        } else {
            return nil
        }
    }
}
