//
//  MockNetworkManager.swift
//  StoreLabTechnicalTaskTests
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation
@testable import StoreLabTechnicalTask
import XCTest

struct MockNetworkManager: ManagerProtocol {
    
    
    var shouldSucceed: Bool = false
     var mockedData: [ImageModel]?
     var mockedError: Error?
    
    
    func  getImageList(page: Int, limit: Int, completion: @escaping (ApiResults<[ImageModel]>) -> Void) {
            
            if shouldSucceed {
                if let data = mockedData {
                    completion(.success(data))
                } else {
                    let error = NSError(domain: "MockAPIClient", code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                if let error = mockedError {
                    completion(.failure(error))
                } else {
                    let error = NSError(domain: "MockAPIClient", code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299: return .success
        case 404: return .success
        case 401...500: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.authenticationError.rawValue]))
        case 501...599: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.badRequest.rawValue]))
        case 600: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.outdated.rawValue]))
        default: return .failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.failed.rawValue]))
        }
    }
}
