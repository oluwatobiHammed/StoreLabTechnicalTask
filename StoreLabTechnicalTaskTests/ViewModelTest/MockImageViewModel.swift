//
//  MockImageViewModel.swift
//  StoreLabTechnicalTaskTests
//
//  Created by Oluwatobi Oladipupo on 07/07/2023.
//

import Foundation
@testable import StoreLabTechnicalTask
import XCTest

class MockImageViewModel: ImageListProtocol {
    
     private var networkManager: ManagerProtocol
     var currentPage: Int = 1
     private var mockedData: [ImageModel] = []
     var mockedError: Error?
    
    init(networkManager: ManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func pagination(index: Int) {
        
    }
    
    func viewDidLoad() {
        
    }
    
    func numberofImages() -> [ImageModel] {
      return mockedData
    }
    
    func getImages() {
        networkManager.getImageList(page: currentPage, limit: 30) { [weak self] result in
            switch result {
            case .success(let images):
                self?.mockedData = images
            case .failure(let err):
                self?.mockedError = err
            }
        }
    }
    
    
}
