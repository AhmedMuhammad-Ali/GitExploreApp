//
//  UsersListViewModel.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 30/10/2023.
//

import Domain
import Core
import Combine
/**
 UsersListViewModel is a view model responsible for managing user data for a user list screen.
 
 It communicates with various use cases to fetch user information and display it in a list.
 */
final class UsersListViewModel: ObservableObject {
    // MARK: - Private Properties
    /// Use case for fetching all users.
    private let usersUseCase: FetchAllUsersUseCase

    /// Use case for fetching all repositories.
    private let reposUseCase: FetchAllReposUseCase

    /// Use case for fetching user followers count.
    private let followersCountUseCase: FetchUserFollowersCountUseCase

    // MARK: - Coordinator
    /// Coordinator for navigating to other screens.
    private weak var coordinator: HomeCoordinatorContact?

    // MARK: - Published Properties
    /// Published property for storing user data.
    @Published private var users: Users = []

    /// Published property for managing the view state.
    @Published private var state: ViewState = .idle

    // MARK: - Init
    /// Initializes the UsersListViewModel.
    ///
    /// - Parameters:
    ///   - coordinator: A coordinator responsible for navigation.
    ///   - usersUseCase: The use case for fetching all users.
    ///   - reposUseCase: The use case for fetching all repositories.
    ///   - followersCountUseCase: The use case for fetching user followers count.
    init(coordinator: HomeCoordinatorContact,
         usersUseCase: FetchAllUsersUseCase,
         reposUseCase: FetchAllReposUseCase,
         followersCountUseCase: FetchUserFollowersCountUseCase) {
        self.coordinator = coordinator
        self.usersUseCase = usersUseCase
        self.reposUseCase = reposUseCase
        self.followersCountUseCase = followersCountUseCase

        fetchAllUsers()
    }
}
// MARK: - ViewModelProtocol
extension UsersListViewModel: ViewModelProtocol {
    /// A publisher that emits the view state changes.
    var statePublisher: AnyPublisher<ViewState, Never> {
        $state.eraseToAnyPublisher()
    }
}

// MARK: - UsersListViewModelInput
extension UsersListViewModel: UsersListViewModelInput {
    /// Handles the user's tap on a user at a specific index.
    ///
    /// - Parameter index: The index of the user in the list.
    func didTappedOnUser(at index: Int) {
        let repos = users[safe: index]?.repos ?? []
        coordinator?.showUserRepsList(with: repos)
    }
}

// MARK: - UsersListViewModelOutput
extension UsersListViewModel: UsersListViewModelOutput {

    /// A range representing the count of users.
    var usersCountRange: Range<Int> {
        .zero..<users.count
    }
    ///  A publisher that emits an array of UserUIModel objects.
    var usersPublisher: AnyPublisher<[UserUIModel], Never> {
        $users.eraseToAnyPublisher()
    }
    ///  The title to display on the screen.
    var screenTitle: String {
        Constants.screenTitle
    }
    /// Subscript to access UserUIModel at a specific index in the user list.
    ///
    /// - Parameter index: The index in the user list.
    /// - Returns: UserUIModel at the given index or a default UserUIModel.
    subscript(index: Int) -> UserUIModel {
        users[safe: index] ?? .init()
    }
    ///  Fetches all users and updates the view state accordingly.
    func fetchAllUsers() {
        state = .loading
        Task {
            do {
                guard let returnedUsers =  try await fetchAllGitHubUsers() else {
                    self.state = .empty
                    return
                }
                let completedUsersWithInfo = try await fetchCompletedUserInfo(users: returnedUsers)
                onUsersListLoaded(completedUsersWithInfo)
            } catch {
                onReceiveError(error)
            }
        }
    }
}

// MARK: - Private Handler(s)
private extension UsersListViewModel {
    /// Fetches all users from the GitHub API asynchronously.
    ///
    /// - Returns: An array of User objects or nil if the fetch fails.
    func fetchAllGitHubUsers() async throws -> [User]? {
        let returnedUsers = try await usersUseCase.usersRepository.fetchAllUsers()
        return returnedUsers
    }
    /// Fetches and completes user information for a given list of users asynchronously.
    ///
    /// - Parameter users: An array of User objects to fetch information for.
    /// - Returns: An array of UserUIModel objects with completed information.
    func fetchCompletedUserInfo(users: [User]) async throws -> Users {
        let userUIModels = try await withThrowingTaskGroup(of: UserUIModel.self) { group in
            users.forEach { user in
                group.addTask {
                    return try await self.createUserCellView(user)
                }
            }
            return try await group.reduce(into: Users()) { (result, userUIModel) in
                result.append(userUIModel)
            }
        }
        return userUIModels.sorted(by: { $0.id < $1.id })
    }
    /// Creates a UserUIModel with additional information for a given user asynchronously.
    ///
    /// - Parameter user: The User object for which to fetch additional information.
    /// - Returns: A UserUIModel with completed information.
    func createUserCellView(_ user: User) async throws -> UserUIModel {
        let repos =  try await self.reposUseCase.execute(by: user.name)
        let followersCount =  try await self.followersCountUseCase(for: user.name)

        return UserUIModel(from: user, repos: repos, followersCount: followersCount)
    }
    /// Handles the completion of the user list loading by updating the view state and user data on the `Main Thread`.
    ///
    /// - Parameter completedUsersWithInfo: An array of UserUIModel objects with completed information.
    func onUsersListLoaded(_ completedUsersWithInfo: [UserUIModel]) {
        Task { @MainActor in
            state = .idle
            users = completedUsersWithInfo
        }
    }
    /// Handles error cases by updating the view state to indicate an error on the `Main Thread`..
    ///
    /// - Parameter error: The error that occurred.
    func onReceiveError(_ error: Error) {
        Task { @MainActor in
            self.state = .error(error)
        }
    }
}
// MARK: - Constants
private extension UsersListViewModel {
    /// Constants used in the UsersListViewModel.
    enum Constants {
        static let screenTitle = "GitHub Users"
    }
}
