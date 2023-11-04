//
//  ViewModelProtocol.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 01/11/2023.
//

import Combine
/// A protocol defining the common interface for view models.
protocol ViewModelProtocol {
    /// A publisher that emits view state updates.
    var statePublisher: AnyPublisher<ViewState, Never> { get }
}
