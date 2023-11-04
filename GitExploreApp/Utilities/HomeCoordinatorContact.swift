//
//  HomeCoordinator.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 02/11/2023.
//

import SwiftUI
import Domain
/// A coordinator responsible for managing the navigation flow within the home module.
protocol HomeCoordinatorContact: AnyObject {
    /// Shows a list of users.
    func showUsersList()

    /// Shows a list of user repositories.
    func showUserRepsList(with repos: [Repo])

    /// Shows a list of forked users.
    func showForkedUserList(using contextDetails: ForkedUsersViewModel.ForkedUserContextDetails)
}
/// A concrete implementation of the `HomeCoordinator` protocol.
final class DefaultHomeCoordinator: Coordinator {
    let navigationController: UINavigationController

    /// Initializes an instance of `DefaultHomeCoordinator`.
    ///
    /// - Parameter navigationController: The navigation controller to use for managing the view hierarchy.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the home coordinator and shows the list of users by default.
    func start() {
        showUsersList()
    }
}
// MARK: - DefaultHomeCoordinator + HomeCoordinator
extension DefaultHomeCoordinator: HomeCoordinatorContact {
    /// Shows a list of users.
    func showUsersList() {
        let usersViewModel = DIContainer.shared.resolve(type: UsersListViewModel.self)
        let rootView = UsersListView(viewModel: usersViewModel)
        let usersViewController = HostingController(rootView: rootView.eraseToAnyView(), viewModel: usersViewModel)
        navigationController.setViewControllers([usersViewController], animated: false)
    }
    /// Shows a list of user repositories.
    func showUserRepsList(with repos: Repos) {
        // Implementation for showing user repositories goes here.
        let viewModel = UserRepositoriesViewModel(repos: repos, coordinator: self)
        let viewController = UserRepositoriesViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    /// Shows a list of forked users.
    func showForkedUserList(using contextDetails: ForkedUsersViewModel.ForkedUserContextDetails) {
        let  forkedUsersUseCase = DIContainer.shared.resolve(type: FetchAllForkedUserUseCase.self)
        let viewModel = ForkedUsersViewModel(contextDetails: contextDetails, forkedUsersUseCase: forkedUsersUseCase)
        let viewController = ForkedUsersViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
