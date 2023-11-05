//
//  EmptyViewStateControllable.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 04/11/2023.
//

import UIKit

typealias EmptyViewModel = EmptyView.ViewModel

/// A protocol defining the common interface for view controllers that can display an empty state view.
protocol EmptyViewStateControllable: ViewControllerProtocol {
    /// The view model representing the empty state.
    var emptyModel: EmptyViewModel { get }
    /// Displays an empty state view with the provided view model.
    ///
    /// - Parameter viewModel: The view model describing the empty state.
    func showEmptyView(with viewModel: EmptyViewModel)
}

extension EmptyViewStateControllable {
    /// Handles view state updates and displays an empty state view if the provided state is empty.
    ///
    /// - Parameter state: The view state to be handled.
    func handleViewState(state: ViewState) {
        if case ViewState.empty = state {
            showEmptyView(with: emptyModel)
        }
    }
    /// Displays an empty state view with the provided view model.
    ///
    /// - Parameter viewModel: The view model describing the empty state.
    func showEmptyView(with viewModel: EmptyViewModel) {
        @NoAutoresizingMask
        var emptyView = EmptyView(using: viewModel)
        emptyView.backgroundColor = .white
        self.view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
