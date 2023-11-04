//
//  UsersListContracts.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 05/11/2023.
//

import Domain
import Combine

/// An array type representing a collection of `UserUIModel` instances.
typealias Users = [UserUIModel]

/// An array type representing a collection of `Repo` instances.
typealias Repos = [Repo]

/// A protocol defining the input methods for a Users List ViewModel.
protocol UsersListViewModelInput {

    /// Notifies the ViewModel when a user is tapped at a specific index.
    /// - Parameter index: The index of the tapped user.
    func didTappedOnUser(at index: Int)
}

/// A protocol defining the output properties and methods for a Users List ViewModel.
protocol UsersListViewModelOutput {

    /// A publisher that emits a collection of `UserUIModel` instances.
    var usersPublisher: AnyPublisher<Users, Never> { get }

    /// A range of indices for the users in the list.
    var usersCountRange: Range<Int> { get }

    /// The title of the screen or view.
    var screenTitle: String { get }

    /// Accesses the `UserUIModel` at a specific index in the list.
    subscript(_ index: Int) -> UserUIModel { get }
}
