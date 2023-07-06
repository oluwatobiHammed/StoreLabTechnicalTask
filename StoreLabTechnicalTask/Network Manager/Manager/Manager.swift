//
//  Manager.swift
//  MovieDetails
//
//  Created by Oladipupo Oluwatobi on 08/06/2023.
//

import Foundation

struct NetworkManager: ManagerProtocol {
    
    let router = Router<ImageListEndpoints>()
    
    
    func getImageList(page: Int, limit: Int, completion: @escaping (ApiResults<[ImageModel]>) -> Void) {
        Task {
            await router.request(.getImages(page: page, limit: limit)) { data, response, error in
                
                if error != nil {
                    completion(.failure(NSError(domain: "", code: URLError.Code.notConnectedToInternet.rawValue, userInfo: [NSLocalizedDescriptionKey : "Please check your network connection."])))
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.noData.rawValue])))
                            return
                        }
                        do {

                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            
                            guard let images = try? [ImageModel].decode(data: responseData) else {
                                completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])))
                                return
                            }
                            guard images.count > 0 else {return}
                            
                            completion(.success(images))
                           
                        } catch {

                            completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])))
                        }
                    case .failure(let networkFailureError):
                        completion(.failure(networkFailureError))
                    }
                }
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


enum ApiResults<T> {
    case success(T)
    case failure(Error)
}
