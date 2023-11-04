//
//  View+Helpers.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 04/11/2023.
//

import SwiftUI

extension View {
    /// Erases the concrete type of a SwiftUI view to `AnyView`.
    ///
    /// Use this extension to convert a SwiftUI view to `AnyView`, which can be useful when you want to hide the specific type of a view.
    ///
    /// - Returns: An `AnyView` wrapping the original view.
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
