//
//  Optional+Helpers.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 03/11/2023.
//

extension Optional where Wrapped == String {
    /// Gets the wrapped string value or an empty string if the optional is nil.
    var value: String {
        return self ?? .empty
    }
}
