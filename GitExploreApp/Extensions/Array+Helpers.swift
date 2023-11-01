//
//  Array+Helper.swift
//  GitExploreApp
//
//  Created by Ahmed Ali on 31/10/2023.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
