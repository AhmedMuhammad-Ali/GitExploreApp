//
//  ForkedUsersViewModelType.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 02/11/2023.
//

import Combine

/// A protocol that defines the input and output requirements for a Forked Users View Model.
typealias ForkedUsersViewModelType = ViewModelProtocol & ForkedUsersViewModelInput & ForkedUsersViewModelOutput

/// A protocol representing the input requirements for a Forked Users View Model.
protocol ForkedUsersViewModelInput {
    /// Fetches all forked users for a specific repository.
    func fetchAllForkedUsers()
}

/// A protocol representing the output requirements for a Forked Users View Model.
protocol ForkedUsersViewModelOutput {
    /// The title associated with the repository.
    var title: String { get }

    /// The number of rows in the list of forked users.
    var numberOfRows: Int { get }

    /// A subject for triggering a table view reload.
    var reloadTableView: PassthroughSubject<Void, Never> { get }

    /// Accesses the `ForkedUserViewModel` at a specific index in the list of forked users.
    /// - Parameter index: The index of the desired repository.
    subscript(index: Int) -> ForkedUserViewModel? { get }
}
