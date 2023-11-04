//
//  ForkedUsersViewController.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 02/11/2023.
//

import SwiftUI
import Combine

class ForkedUsersViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    private let viewModel: ForkedUsersViewModelType
    var cancellable: Set<AnyCancellable> = []
    @NoAutoresizingMask
    var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    // MARK: - Init(s)
    init(viewModel: ForkedUsersViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        configureTableView()
        configureNavigationTitle()

        configureBinding()
        viewModel.fetchAllForkedUsers()
    }
}
// MARK: - Configure Appearance
private extension ForkedUsersViewController {
    /// Sets up Auto Layout constraints for the loading indicator.
    func setupConstraint() {
        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    /// Configures the table view's delegate and data source.
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(cell: UITableViewCell.self)
    }
    /// Sets the navigation title of the view controller.
    func configureNavigationTitle() {
        self.title = viewModel.title
    }
    /// Configures data binding for the view model's state and table view reloading.
    func configureBinding() {
        configureStateBinding(state: viewModel.statePublisher)
        viewModel.reloadTableView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
}
// MARK: - ForkedUsersViewController + ForkedUsersViewController
extension ForkedUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        guard let user = viewModel[indexPath.row] else { return UITableViewCell() }
        cell.contentConfiguration = UIHostingConfiguration {
            Group {
                GitHubUserView(user: .init(
                    userName: user.userName,
                    userAvatar: user.userAvatar)
                )
                .padding(Dimensions.d16)
                .background(.white)
            } //: Group
            .cornerRadius(Dimensions.d12)
        } //: UIHostingConfiguration
        .background(.clear)
        return cell
    }
}
// MARK: - ForkedUsersViewController + UITableViewDataSource
extension ForkedUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
}

// MARK: - ForkedUsersViewController + LoadingStateControllable
extension ForkedUsersViewController: LoadingStateControllable {
    var emptyModel: EmptyViewModel {
        EmptyViewModel(title: Constants.emptyViewTitle, description: Constants.emptyViewDescription)
    }
}
// MARK: - Constants
private extension ForkedUsersViewController {
    enum Constants {
        static let emptyViewTitle = "No Forked Users Found"
        static let emptyViewDescription = "There are no forked users for this repository at the moment."
    }
}
