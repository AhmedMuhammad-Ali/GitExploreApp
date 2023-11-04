//
//  LoadingStateControllable.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 04/11/2023.
//

import UIKit
/// A protocol defining the common interface for view controllers that can display loading indicators and handle errors.
protocol LoadingStateControllable: ViewControllerProtocol, EmptyViewStateControllable {
    /// The loading indicator view associated with the view controller.
    var loadingIndicator: UIActivityIndicatorView { get }

    /// Shows the loading indicator to indicate ongoing data loading.
    func showLoadingIndicator()

    /// Hides the loading indicator when data loading is complete.
    func hideLoadingIndicator()

    /// Displays an error to the user, typically when data loading encounters an error.
    ///
    /// - Parameter error: The error to be displayed.
    func showError(with error: Error)
}

extension LoadingStateControllable {
    /// Displays the loading indicator, typically to indicate ongoing data loading.
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }

    /// Hides the loading indicator, indicating that data loading is complete.
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }

    /// Displays an error to the user, typically when data loading encounters an error.
    ///
    /// - Parameter error: The error to be displayed.
    func showError(with error: Error) {
        let alertController = UIAlertController(
            title: "Error!!",
            message: error.localizedDescription,
            preferredStyle: .alert)

        self.present(alertController, animated: true)
    }

    /// Handles view state updates and performs actions based on the state.
    ///
    /// - Parameter state: The view state to be handled.
    func handleViewState(state: ViewState) {
        switch state {
        case .idle:
            hideLoadingIndicator()
        case .loading:
            showLoadingIndicator()
        case .empty:
            showEmptyView(with: emptyModel)
        case .error(let error):
            showError(with: error)
        }
    }
}
