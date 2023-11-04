//
//  FetchAllUserUseCaseTest.swift
//  GitExploreAppTests
//
//  Created by Ahmed Ali on 04/11/2023.
//

@testable import GitExploreApp
@testable import Networking
@testable import Domain

import XCTest

class FetchAllUserUseCaseTest: XCTestCase {
    // MARK: - Properties
    var sut: FetchAllUsersUseCase?

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        SessionManager.shared.configure(protocols: [MockURLProtocol.self])
        MockURLProtocol.mockData["/users"] = Data(fileName: "Users")
        sut = DIContainer.shared.resolve(type: FetchAllUsersUseCase.self)
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Tests
    func test_fetchAllUsers_returnedSuccessfully() async throws {
        let users = try await sut?.execute()
        let actualName = users?.first?.name
        let expectedName = "Ahmed Ali"
        XCTAssertEqual(actualName, expectedName)
    }
}
