//
//  UserRepositoriesViewController.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

import UIKit
import Domain
import Combine

class UserRepositoriesViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private var viewModel: UserRepositoriesViewModelType
    var cancellable: Set<AnyCancellable> = []

    // MARK: - Init(s)
    init(viewModel: UserRepositoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        configureTableView()
        configureStateBinding(state: viewModel.statePublisher)
    }
}
// MARK: - Configure Appearance
private extension UserRepositoriesViewController {
    /// Sets the navigation title of the view controller.
    func configureNavigationTitle() {
        self.title = viewModel.title
    }
    ///   /// Configures the appearance and behavior of the table view.
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(cell: UserRepositoryCell.self)
    }

}
// MARK: - UserRepositoriesViewController + UITableViewDelegate
extension UserRepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didTappedOnRepository(at: indexPath.row)
    }
}
// MARK: - UserRepositoriesViewController + UITableViewDataSource
extension UserRepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.reposCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserRepositoryCell = tableView.dequeueReusableCell(for: indexPath)
        let repo = viewModel[indexPath.row]

        cell.configure(with: repo)
        return cell
    }
}

// MARK: - UserRepositoriesViewController + EmptyViewStateControllable
extension UserRepositoriesViewController: EmptyViewStateControllable {
    /// An empty view model to display when no repositories are found.
    var emptyModel: EmptyViewModel {
        EmptyViewModel(title: Constants.emptyViewTitle, description: Constants.emptyViewDescription)
    }
}

// MARK: - Constants
private extension UserRepositoriesViewController {
    enum Constants {
        static let emptyViewTitle = "No Repositories Found"
        static let emptyViewDescription =
        "This GitHub user has not created any repositories yet. Start by creating a new repository or exploring other users' repositories."
    }
}
