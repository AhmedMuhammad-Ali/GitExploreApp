//
//  UserListHostingController.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 04/11/2023.
//

import SwiftUI
import Combine

/// A custom UIHostingController used to host a SwiftUI view and manage loading state.
class UserListHostingController<Content>: UIHostingController<Content> where Content: View {

    // MARK: - Properties
    var cancellable: Set<AnyCancellable> = []
    var viewModel: UsersListViewModel

    /// An activity indicator to display when loading data.
    @NoAutoresizingMask
    var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()

    // MARK: - Init(s)
    init(rootView: Content, viewModel: UsersListViewModel) {
        self.viewModel = viewModel
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configureStateBinding(state: viewModel.statePublisher)
    }

    // MARK: - Configure Views
    func setupConstraints() {
        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - HostingController + LoadingStateControllable
extension UserListHostingController: LoadingStateControllable {

    /// An empty view model to display when no GitHub users are found.
    var emptyModel: EmptyViewModel {
        EmptyViewModel(title: Constants.emptyViewTitle, description: Constants.emptyViewDescription)
    }
}

// MARK: - Constants
private extension UserListHostingController {

    /// Constants used in the `UserListHostingController`.
    enum Constants {
        static var emptyViewTitle: String {
            "No GitHub Users Found"
        }
        static var emptyViewDescription: String {
            "There are currently no GitHub users available at the moment"
        }
    }
}
