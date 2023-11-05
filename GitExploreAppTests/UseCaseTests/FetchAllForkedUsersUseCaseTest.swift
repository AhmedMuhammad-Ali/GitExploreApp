//
//  FetchAllForkedUsersUseCaseTest.swift
//  GitExploreAppTests
//
//  Created by Ahmed Ali on 04/11/2023.
//

import Foundation
@testable import GitExploreApp
@testable import Networking
@testable import Domain

import XCTest

class FetchAllForkedUsersUseCaseTest: XCTestCase {
    // MARK: - Properties
    var sut: FetchAllForkedUserUseCase!

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        SessionManager.shared.configure(protocols: [MockURLProtocol.self])
        MockURLProtocol.mockData["/repos/mojombo/30daysoflaptops.github.io/forks"] = Data(fileName: "ForkedUsers")
        sut = DIContainer.shared.resolve(type: FetchAllForkedUserUseCase.self)
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Tests
    func test_fetchAllForkedUsers_returnedSuccessfully() async throws {
        let users = try await sut.execute(byOwner: "mojombo", for: "30daysoflaptops.github.io")
        let actualName = users.first?.name
        let expectedName = "Ahmed Ali"
        XCTAssertEqual(actualName, expectedName)
    }
}
