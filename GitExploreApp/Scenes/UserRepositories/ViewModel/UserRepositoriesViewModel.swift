//
//  UserRepositoriesViewModel.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

import Domain
import Core
import Combine

class UserRepositoriesViewModel {

    // MARK: - Properties
    @Published private var state: ViewState = .idle
    private var repos: Repos
    private weak var coordinator: HomeCoordinatorContact?

    // MARK: - Init
    /// Initializes a `UserRepositoriesViewModel` with a list of repositories and a coordinator.
    /// - Parameters:
    ///   - repos: The list of repositories to manage.
    ///   - coordinator: The coordinator responsible for navigation.
    init(repos: Repos, coordinator: HomeCoordinatorContact) {
        self.coordinator = coordinator
        self.repos = repos
        handleViewState()
    }

    // MARK: - Private Methods
    /// Handles the view state based on the availability of repositories.
    private func handleViewState() {
        state = repos.isEmpty ? .empty : .idle
    }
}

extension UserRepositoriesViewModel: ViewModelProtocol {
    /// A publisher emitting the view state of the user repositories.
    var statePublisher: AnyPublisher<ViewState, Never> {
        $state.eraseToAnyPublisher()
    }
}
extension UserRepositoriesViewModel: UserReposViewModelInput {
    /// Notifies the view model when a repository is tapped at a specific index.
    /// - Parameter index: The index of the tapped repository.
    func didTappedOnRepository(at index: Int) {
        guard let repo = repos[safe: index], let owner = repo.owner else { return }
        coordinator?.showForkedUserList(using: .init(userName: owner.name, repoName: repo.name))
    }
    /// The title associated with the repository.
    var title: String {
        "\(repos.first?.owner?.name ?? "")'s Repositories"
    }
}
extension UserRepositoriesViewModel: UserReposViewModelOutput {
    /// The count of repositories managed by the view model.
    var reposCount: Int {
        repos.count
    }
    /// Accesses the `UserRepositoryUIModel` at a specific index in the view model.
    /// - Parameter index: The index of the desired repository.
    subscript(index: Int) -> UserRepositoryUIModel {
        guard let repo = repos[safe: index] else { return .init() }
        return UserRepositoryUIModel(from: repo)
    }
}
