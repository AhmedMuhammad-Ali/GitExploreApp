//
//  UserStorage.swift
//  
//
//  Created by Ahmed Ali on 05/11/2023.
//

import Domain
/// `UserStorage` protocol defines the interface for storing and retrieving user data.
public protocol UserStorage {
    /// Save a user to the storage.
    ///
    /// - Parameter user: The `User` object to be saved.
    func saveUser(_ user: User)
    /// Fetch all users from the storage.
    ///
    /// - Returns: An array of `User` objects.
    func fetchAllUsers() -> [User]
}
/// `DefaultUserStorage` is an implementation of the `UserStorage` protocol using CoreData.
public final class DefaultUserStorage: UserStorage {
    private let coreDataWrapper: CoreDataWrapping
    /// Initializes a `DefaultUserStorage` with an optional `CoreDataWrapping` instance.
    ///
    /// - Parameter coreDataWrapper: An optional `CoreDataWrapping` instance. If not provided, it uses the default `CoreDataManager` with the model name.
    public init(coreDataWrapper: CoreDataWrapping = CoreDataManager(modelName: "GitExploreCoreDataModel")) {
        self.coreDataWrapper = coreDataWrapper
    }
    /// Save a user to the storage.
    ///
    /// - Parameter user: The `User` object to be saved.
    public func saveUser(_ user: User) {
        let object = coreDataWrapper.createObject(ofType: UserEntity.self)

        object.userId = Int64(user.id)
        object.userName = user.name
        object.userAvatarUrl = user.avatarUrl

        coreDataWrapper.saveContext()
    }
    /// Fetch all users from the storage.
    ///
    /// - Returns: An array of `User` objects.
    public func fetchAllUsers() -> [User] {
        let objects = coreDataWrapper.fetchObjects(ofType: UserEntity.self,
                                                   predicate: nil,
                                                   sortDescriptors: nil)
        return objects.compactMap { $0.toDomain() }
    }
}
