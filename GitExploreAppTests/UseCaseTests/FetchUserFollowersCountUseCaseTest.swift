//
//  FetchUserFollowersCountUseCaseTest.swift
//  GitExploreAppTests
//
//  Created by Ahmed Ali on 04/11/2023.
//

import Foundation
@testable import GitExploreApp
@testable import Networking
@testable import Domain

import XCTest

class FetchUserFollowersCountUseCaseTest: XCTestCase {
    // MARK: - Properties
    var sut: FetchUserFollowersCountUseCase!

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        SessionManager.shared.configure(protocols: [MockURLProtocol.self])
        MockURLProtocol.mockData["/users/mojombo/followers"] = Data(fileName: "Followers")
        sut = DIContainer.shared.resolve(type: FetchUserFollowersCountUseCase.self)
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Test
    func test_fetchFollowersCount_returnedSuccessfully() async throws {
        let actualFollowersCount = try await sut(for: "mojombo")
        let expectedFollowersCount = 30
        XCTAssertEqual(actualFollowersCount, expectedFollowersCount)
    }
}
