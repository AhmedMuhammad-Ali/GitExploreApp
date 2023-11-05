//
//  Array+Helper.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

extension Array {
    /// Safely retrieves an element at the specified index if it is within the array's bounds.
    ///
    /// - Parameter safe: The index to access safely.
    /// - Returns: The element at the specified index if it exists, or `nil` if the index is out of bounds.
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
