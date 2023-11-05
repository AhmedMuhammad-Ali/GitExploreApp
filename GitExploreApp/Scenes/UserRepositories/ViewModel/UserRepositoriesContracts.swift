//
//  UserRepositoriesContracts.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 05/11/2023.
//

import Foundation

/// A type alias for a repository UI model, equivalent to `UserRepositoryCell.ViewModel`.
typealias UserRepositoryUIModel = UserRepositoryCell.ViewModel

/// A type alias representing the protocol composition of a view model for user repositories.
typealias UserRepositoriesViewModelType = ViewModelProtocol & UserReposViewModelInput & UserReposViewModelOutput

/// A protocol defining the input methods for a user repositories view model.
protocol UserReposViewModelInput {

    /// Notifies the view model when a repository is tapped at a specific index.
    /// - Parameter index: The index of the tapped repository.
    func didTappedOnRepository(at index: Int)
}

/// A protocol defining the output properties and methods for a user repositories view model.
protocol UserReposViewModelOutput {

    /// The count of repositories in the view model.
    var reposCount: Int { get }

    /// Accesses the `UserRepositoryUIModel` at a specific index in the view model.
    subscript (index: Int) -> UserRepositoryUIModel { get }
}
