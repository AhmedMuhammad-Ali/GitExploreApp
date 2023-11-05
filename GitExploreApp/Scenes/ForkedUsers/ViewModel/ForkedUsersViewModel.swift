//
//  ForkedUsersViewModel.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 02/11/2023.
//

import Domain
import Core
import Combine

/// A view model for managing a list of forked users for a specific repository.
final class ForkedUsersViewModel {

    // MARK: - Properties

    /// Publisher for the view state of the `ForkedUsersViewModel`.
    @Published private var state: ViewState = .idle

    /// Details of the forked user context.
    private let contextDetails: ForkedUserContextDetails

    /// Use case for fetching forked users.
    private let forkedUsersUseCase: FetchAllForkedUserUseCase

    /// List of forked users.
    private var users: [User] = []

    /// A subject for triggering a table view reload.
    let reloadTableView: PassthroughSubject<Void, Never> = .init()

    // MARK: - Init

    /// Initializes a `ForkedUsersViewModel` with context details and a use case.
    /// - Parameters:
    ///   - contextDetails: Details of the forked user context.
    ///   - forkedUsersUseCase: The use case for fetching forked users.
    init(contextDetails: ForkedUserContextDetails, forkedUsersUseCase: FetchAllForkedUserUseCase) {
        self.contextDetails = contextDetails
        self.forkedUsersUseCase = forkedUsersUseCase
    }
}

// MARK: - ForkedUsersViewModel + ForkedUsersViewModelInput
extension ForkedUsersViewModel: ForkedUsersViewModelInput {

    /// Fetches all forked users for the specified repository.
    func fetchAllForkedUsers() {
        state = .loading
        Task {
            do {
                users = try await forkedUsersUseCase.execute(
                    byOwner: contextDetails.userName,
                    for: contextDetails.repoName
                )
                onUsersListLoaded()
            } catch {
                state = .error(error)
            }
        }
    }

}

// MARK: - UsersListViewModelOutput
extension ForkedUsersViewModel: ForkedUsersViewModelOutput {

    /// The number of rows in the list of forked users.
    var numberOfRows: Int {
        users.count
    }

    /// The title associated with the repository.
    var title: String {
        contextDetails.repoName
    }

    /// Accesses the `ForkedUserViewModel` at a specific index in the list of forked users.
    /// - Parameter index: The index of the desired repository.
    subscript(index: Int) -> ForkedUserViewModel? {
        guard let user = users[safe: index] else { return nil }
        return .init(from: user)
    }
}

// MARK: - ViewModelProtocol
extension ForkedUsersViewModel: ViewModelProtocol {

    /// A publisher emitting the view state of the `ForkedUsersViewModel`.
    var statePublisher: AnyPublisher<ViewState, Never> {
        $state.eraseToAnyPublisher()
    }
}

private extension ForkedUsersViewModel {

    /// Handles the view state based on the availability of forked users and triggers a table view reload.
    private func onUsersListLoaded() {
        state = users.isEmpty ? .empty : .idle
        reloadTableView.send()
    }
}
