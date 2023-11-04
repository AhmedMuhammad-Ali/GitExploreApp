//
//  DIContainer.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 03/11/2023.
//

import Foundation

/// A Dependency Injection Container that allows registering and resolving dependencies.
final class DIContainer {

    /// A typealias for a factory that creates dependencies.
    typealias DependencyFactory = [String: () -> Any]

    /// A typealias for a factory that stores shared dependencies.
    typealias SharedDependencyFactory = [String: Any]

    /// The shared instance of the DIContainer.
    static let shared = DIContainer()

    /// The factory for non-shared dependencies.
    private var dependenciesFactory: DependencyFactory = [:]

    /// The factory for shared dependencies.
    private var sharedDependenciesFactory: SharedDependencyFactory = [:]

    private init() { }

    /// Registers a dependency with the DIContainer.
    ///
    /// - Parameters:
    ///   - type: The type of the dependency.
    ///   - objectScope: The object scope (singleton or transient).
    ///   - dependencyFactory: A closure that provides the dependency instance.
    func register<Dependency>(
        type: Dependency.Type,
        objectScope: ObjectScope = .transient,
        _ dependencyFactory: @escaping () -> Dependency
    ) {
        switch objectScope {
        case .singleton:
            sharedDependenciesFactory["\(type)"] = dependencyFactory()
        case .transient:
            dependenciesFactory["\(type)"] = dependencyFactory
        }
    }

    /// Resolves a dependency from the DIContainer.
    ///
    /// - Parameters:
    ///   - type: The type of the dependency.
    ///   - objectScope: The object scope (singleton or transient).
    /// - Returns: The resolved dependency instance.
    func resolve<Dependency>(
        type: Dependency.Type,
        objectScope: ObjectScope = .transient
    ) -> Dependency {
        switch objectScope {
        case .singleton:
            guard let dependency = sharedDependenciesFactory["\(type)"] as? Dependency else {
                fatalError("Dependency not found for type \(type)")
            }
            return dependency
        case .transient:
            guard let dependency = dependenciesFactory["\(type)"]?() as? Dependency else {
                fatalError("Dependency not found for type \(type)")
            }
            return dependency
        }
    }
}

/// An enumeration representing the object scope for a dependency.
enum ObjectScope {
    case singleton
    case transient
}
