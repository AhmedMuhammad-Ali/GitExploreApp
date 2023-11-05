//
//  FetchAllUserReposUseCaseTests.swift
//  GitExploreAppTests
//
//  Created by Ahmed Ali on 04/11/2023.
//

@testable import GitExploreApp
@testable import Networking
@testable import Domain

import XCTest

class FetchAllUserReposUseCaseTests: XCTestCase {
    // MARK: - Properties
    var sut: FetchAllReposUseCase?

    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        SessionManager.shared.configure(protocols: [MockURLProtocol.self])
        MockURLProtocol.mockData["/users/mojombo/repos"] = Data(fileName: "Repos")
        sut = DIContainer.shared.resolve(type: FetchAllReposUseCase.self)
    }
    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Tests
    func test_fetchAllUserRepos_returnedSuccessfully() async throws {
        let repos = try await sut?.execute(by: "mojombo")
        let actualName = repos?.first?.name
        let expectedName = "GitExploreApp"
        XCTAssertEqual(actualName, expectedName)
    }
}
