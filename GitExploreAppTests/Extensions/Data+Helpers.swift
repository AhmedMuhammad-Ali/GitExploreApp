//
//  Data+Helpers.swift
//  GitExploreAppTests
//
//  Created by Ahmed Ali on 04/11/2023.
//

import Foundation

extension Data {
    /// Initializes `Data` from a file with a given filename and file extension.
    ///
    /// - Parameters:
    ///   - fileName: The name of the file without the extension.
    ///   - extension: The file extension, which defaults to "json."
    init?(fileName: String, extension: String = "json") {
        let bundle = Bundle(for: MockURLProtocol.self)
        // Find the URL for the file in the specified bundle.
        guard let url = bundle.url(forResource: fileName, withExtension: `extension`) else {
            return nil
        }
        // Try to initialize `Data` from the contents of the file.
        try? self.init(contentsOf: url)
    }
}
