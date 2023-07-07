//
//  ImageViewListViewModel.swift
//  StoreLabTechnicalTaskTests
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import XCTest
@testable import StoreLabTechnicalTask

final class ImageViewListViewModel: XCTestCase {
    
    private var sut: ImageListProtocol!
    
    override func setUpWithError() throws {
        
        sut = MockImageViewModel(networkManager: MockNetworkManager())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetImages() throws {
        let images = Bundle.main.decodeJSONFromFile(fileName: "Image", type: [ImageModel].self)!
        var mockAPIClient = MockNetworkManager()
        mockAPIClient.shouldSucceed = true
        mockAPIClient.mockedData = images
        sut = MockImageViewModel(networkManager: mockAPIClient)
        sut.getImages()
        
        
        XCTAssertEqual(sut.numberofImages().first!.author, "Shyamanta Baruah", "not the same author name")
        XCTAssertEqual(sut.numberofImages().first!.width, 1280, "not the same image width")
        XCTAssertEqual(sut.numberofImages().first!.height, 901, "not the same image height")
        XCTAssertEqual(sut.numberofImages().first!.url, "https://unsplash.com/photos/aeVA-j1y2BY", "not the same image url")
        XCTAssertEqual(sut.numberofImages().first!.download_url, "https://picsum.photos/id/30/1280/901", "not the same image downloaded url")
        
    }
    
    
}
