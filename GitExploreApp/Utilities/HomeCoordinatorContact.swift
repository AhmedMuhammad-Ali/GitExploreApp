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
    func showForkedUserList()
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
        let usersViewModel = UsersListViewModel(coordinator: self)
        let rootView = UsersListView(viewModel: usersViewModel)
        let userListViewController = UIHostingController(rootView: rootView)
        navigationController.setViewControllers([userListViewController], animated: false)
    }

    /// Shows a list of user repositories.
    func showUserRepsList(with repos: [Repo]) {
        // Implementation for showing user repositories goes here.
        let viewModel = UserRepositoriesViewModel(repos: repos, coordinator: self)
        let viewController = UserRepositoriesViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)

    }

    /// Shows a list of forked users.
    func showForkedUserList() {
        // Implementation for showing forked user list goes here.
    }
}
