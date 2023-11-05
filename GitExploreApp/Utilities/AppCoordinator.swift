//
//  AppCoordinator.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 02/11/2023.
//

import SwiftUI
import Domain
import Core

/// A coordinator responsible for managing the app's navigation flows.
final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private var children: [Coordinator] = []
    var navigationController: UINavigationController

    /// Initializes an instance of `AppCoordinator`.
    ///
    /// - Parameters:
    ///   - window: The main application window.
    ///   - navigationController: The root navigation controller for the app.
    init(window: UIWindow, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.window = window
    }

    /// Starts the app coordinator by configuring dependencies and displaying the home flow.
    func start() {
        configureDependencies()
        displayHomeFlow()
    }
}

// MARK: Flows Helpers
private extension AppCoordinator {

    /// Displays the home flow by initializing and starting the `DefaultHomeCoordinator`.
    func displayHomeFlow() {
        let coordinator = DIContainer.shared.resolve(type: DefaultHomeCoordinator.self, objectScope: .singleton)
        coordinator.start()
        children.append(coordinator)
        replaceRootViewController(navigationController)
    }
}

// MARK: Window Replacement
private extension AppCoordinator {

    /// Replaces the root view controller of the app's window.
    ///
    /// This method sets the specified view controller as the root view controller of the app's window,
    /// and makes the window visible.
    ///
    /// - Parameter viewController: The view controller to set as the root view controller.
    func replaceRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {

    /// Configures all necessary dependencies for the app.
    func configureDependencies() {
        configureUsersDependencies()
        configureForkedDependencies()
    }

    func configureUsersDependencies() {
        configureReposDependencies()
        configureUseCasesDependencies()
        configureCoordinatorDependencies()
        configureViewModelDependencies()
    }

    func configureReposDependencies() {
        DIContainer.shared.register(type: UsersRepository.self) {
            return DefaultUsersRepository()
        }
        DIContainer.shared.register(type: UserReposRepository.self) {
            return DefaultUserReposRepository()
        }
        DIContainer.shared.register(type: FollowersRepository.self) {
            return DefaultFollowersRepository()
        }
    }

    func configureUseCasesDependencies() {
        DIContainer.shared.register(type: FetchAllUsersUseCase.self) {
            return DefaultFetchAllUsersUseCase(DIContainer.shared.resolve(type: UsersRepository.self))
        }

        DIContainer.shared.register(type: FetchAllReposUseCase.self) {
            return DefaultFetchAllUserRepoUseCase(DIContainer.shared.resolve(type: UserReposRepository.self))
        }

        DIContainer.shared.register(type: FetchUserFollowersCountUseCase.self) {
            return DefaultFetchUserFollowersCountUseCase(DIContainer.shared.resolve(type: FollowersRepository.self))
        }
    }

    func configureCoordinatorDependencies() {
        DIContainer.shared.register(type: DefaultHomeCoordinator.self, objectScope: .singleton) { [unowned self] in
            return DefaultHomeCoordinator(navigationController: self.navigationController)
        }
    }

    func configureViewModelDependencies() {
        DIContainer.shared.register(type: UsersListViewModel.self) {
            let coordinator = DIContainer.shared.resolve(type: DefaultHomeCoordinator.self, objectScope: .singleton)
            let fetchAllUsersUseCase = DIContainer.shared.resolve(type: FetchAllUsersUseCase.self)
            let fetchAllReposUseCase = DIContainer.shared.resolve(type: FetchAllReposUseCase.self)
            let fetchUserFollowersCountUseCase = DIContainer.shared.resolve(type: FetchUserFollowersCountUseCase.self)
            return UsersListViewModel(
                coordinator: coordinator,
                usersUseCase: fetchAllUsersUseCase,
                reposUseCase: fetchAllReposUseCase,
                followersCountUseCase: fetchUserFollowersCountUseCase
            )
        }
    }

    func configureForkedDependencies() {
        configureForkedReposDependencies()
        configureForkedUseCasesDependencies()
    }

    func configureForkedReposDependencies() {
        DIContainer.shared.register(type: ForkedUsersRepository.self) {
            return DefaultForkedUsersRepository()
        }
    }

    func configureForkedUseCasesDependencies() {
        DIContainer.shared.register(type: FetchAllForkedUserUseCase.self) {
            return DefaultFetchAllForkedUserUseCase(DIContainer.shared.resolve(type: ForkedUsersRepository.self))
        }
    }
}
