//
//  BaseViewController.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 03/11/2023.
//

import SwiftUI
import Combine
/// A protocol defining the common interface for view controllers.
protocol ViewControllerProtocol where Self: UIViewController {
    /// A set of cancellables used for managing Combine subscriptions.
    var cancellable: Set<AnyCancellable> { get set }
    /// Configures the binding of the view controller's state to a publisher.
    ///
    /// - Parameter state: A publisher emitting view state updates.
    func configureStateBinding(state: AnyPublisher<ViewState, Never>)
    /// Handles the view state updates received from the configured publisher.
    ///
    /// - Parameter state: The view state to be handled.
    func handleViewState(state: ViewState)
}
/// Default implementation for `configureStateBinding`
extension ViewControllerProtocol {
    /// Configures the binding of the view controller's state to a publisher.
    ///
    /// - Parameter state: A publisher emitting view state updates.
    func configureStateBinding(state: AnyPublisher<ViewState, Never>) {
        state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.handleViewState(state: $0)
            }
            .store(in: &cancellable)
    }
}
