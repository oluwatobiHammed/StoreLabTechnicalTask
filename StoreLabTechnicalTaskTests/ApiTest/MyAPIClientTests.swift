//
//  MyAPIClientTests.swift
//  StoreLabTechnicalTaskTests
//
//  Created by Oluwatobi Oladipupo on 07/07/2023.
//

import XCTest
@testable import StoreLabTechnicalTask

class MyAPIClientTests: XCTestCase {
    
    private var sut: ManagerProtocol!
    
    override func setUpWithError() throws {
        sut = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchData_Success() {
        
        let images = Bundle.main.decodeJSONFromFile(fileName: "Image", type: [ImageModel].self)!
        
        // Set up the mock to succeed and provide mocked data
        var mockAPIClient = sut as! MockNetworkManager
        mockAPIClient.shouldSucceed = true
        mockAPIClient.mockedData = images
        
        // Perform the test
        mockAPIClient.getImageList(page: 1, limit: 30) { result in
            switch result {
            case .success(let data):
                // Assert that the data is as expected
                XCTAssertEqual(data, images)
            case .failure:
                XCTFail("Should not have returned failure")
            }
        }
    }
    
    func testFetchData_Failure() {
        
        // Set up the mock to fail and provide a mocked error
        var mockAPIClient = sut as! MockNetworkManager
        mockAPIClient.shouldSucceed = false
        mockAPIClient.mockedError = NSError(domain: "MockAPIClient", code: 0, userInfo: nil)
        
        // Perform the test
        mockAPIClient.getImageList(page: 1, limit: 30) { result in
            switch result {
            case .success:
                XCTFail("Should not have returned success")
            case .failure(let error as NSError):
                // Assert that the error is as expected
                XCTAssertEqual(error.domain, "MockAPIClient")
            }
        }
    }
}
