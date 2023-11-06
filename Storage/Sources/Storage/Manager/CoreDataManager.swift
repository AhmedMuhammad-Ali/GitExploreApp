//
//  CoreDataManager.swift
//  
//
//  Created by Ahmed Ali on 05/11/2023.
//

import CoreData
/// A protocol for CoreData entities, extending NSManagedObject, with a method to create an associated fetch request.
public protocol Object: NSManagedObject {
    /// Creates and returns a fetch request for the specified CoreData entity.
    /// - Returns: A fetch request for the entity.
    static func fetchRequest() -> NSFetchRequest<Self>
}
/// A protocol for wrapping CoreData operations, including saving, creating objects, and fetching objects.
public protocol CoreDataWrapping {
    /// Saves changes made to the CoreData context.
    func saveContext()
    /// Creates an instance of a specified CoreData entity type.
    /// - Parameter type: The type of the CoreData entity to create.
    /// - Returns: An instance of the specified entity type.
    func createObject<T: Object>(ofType type: T.Type) -> T
    /// Fetches instances of a specified CoreData entity type based on optional criteria.
    /// - Parameters:
    ///   - type: The type of the CoreData entity to fetch.
    ///   - predicate: An optional predicate to filter results.
    ///   - sortDescriptors: An optional array of sort descriptors to order results.
    /// - Returns: An array of fetched entities.
    func fetchObjects<T: Object>(ofType type: T.Type,
                                 predicate: NSPredicate?,
                                 sortDescriptors: [NSSortDescriptor]?) -> [T]
    /// Retrieves the first object of a specified type that matches the given predicate.
    ///
    /// - Parameters:
    ///   - type: The type of object to retrieve.
    ///   - predicate: An optional NSPredicate used to filter the objects. Pass `nil` to retrieve all objects of the specified type.
    ///
    /// - Returns: The first object of the specified type that matches the predicate, or `nil` if no matching object is found.
    func firstObject<T: Object>(ofType type: T.Type,
                                matching predicate: NSPredicate?) -> T?
}
/// A class that implements the CoreDataWrapping protocol, providing methods for managing CoreData operations.
public final class CoreDataManager: CoreDataWrapping {
    private let persistentContainer: NSPersistentContainer
    /// Initializes the CoreDataWrapper with the specified CoreData model name.
    /// - Parameter modelName: The name of the CoreData model to use.
    public init(modelName: String) {
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to create model with name: \(modelName) in module bundle")
        }

        persistentContainer = NSPersistentContainer(name: modelName, managedObjectModel: model)
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    public func createObject<T: Object>(ofType type: T.Type) -> T {
        return T(context: persistentContainer.viewContext)
    }

    public func fetchObjects<T: Object>(ofType type: T.Type,
                                        predicate: NSPredicate? = nil,
                                        sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    public func firstObject<T: Object>(ofType type: T.Type,
                                       matching predicate: NSPredicate? = nil) -> T? {
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest).first
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }

}
