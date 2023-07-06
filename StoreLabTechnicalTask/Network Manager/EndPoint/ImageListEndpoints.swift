//
//  MoviesEndpoints.swift
//  MovieDetails
//
//  Created by Oladipupo Oluwatobi on 08/06/2023.
//

import Foundation

enum ImageListEndpoints: EndPointType {

    case getImages(page: Int, limit:Int)
    
    var baseURL: URL {
        guard let url = URL(string: kAPI.Base_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getImages:
            return kAPI.Endpoints.imageList
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
        
    }
    
    var task: HTTPTask {
        switch self {
            
            case .getImages(let page, let limit):
                return .requestParametersAndHeaders(bodyParameters: nil,
                                                    bodyEncoding: .urlEncoding,
                                                    urlParameters: ["page" : page, "limit": limit],
                                                    additionHeaders: nil)
        }
    }
    
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            
            return nil
            
            
        }
    }
    
}



extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
