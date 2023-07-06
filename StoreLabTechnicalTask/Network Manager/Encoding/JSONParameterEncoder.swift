//
//  JSONParameterEncoder.swift
//  MovieDetails
//
//  Created by Oladipupo Oluwatobi on 08/06/2023.
//

import Foundation
import UIKit

public struct JSONParameterEncoder: ParameterEncoder {

    public func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    public func encode(urlRequest: inout URLRequest, withArrayParameters arrayParameters: ArrayParameters) throws {
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            urlRequest.httpBody = try encoder.encode(arrayParameters)
            
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    public func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters? = nil, withImageTuple tupleImage: (UIImage?, String)?) throws {

        guard let tupleImage = tupleImage, let image = tupleImage.0 else {
            throw NetworkError.encodingFailed
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = createBody(parameters: parameters, boundary: boundary, data: image.jpegData(compressionQuality: 0.4)!, mimeType: "image/jpg", fieldName: tupleImage.1)

        
    }
    
    
    
    func createBody(parameters: Parameters? = nil, boundary: String, data: Data, mimeType: String, fieldName: String) -> Data {
        
        let body = NSMutableData()
        var bodyString = ""
        
        let boundaryPrefix = "--\(boundary)\r\n"
        

        if let parameters = parameters {
            for (key, value) in parameters {
                body.appendString(boundaryPrefix)
                
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
                
                bodyString = bodyString.appending(boundaryPrefix)
                
                bodyString = bodyString.appending("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                bodyString = bodyString.appending("\(value)\r\n")
            }
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"profile.jpg\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--\r\n")))
        
        bodyString = bodyString.appending(boundaryPrefix)
        bodyString = bodyString.appending("Content-Disposition: form-data; name=\"picture\"; filename=\"profile.jpg\"\r\n")
        bodyString = bodyString.appending("Content-Type: \(mimeType)\r\n\r\n")
        bodyString = bodyString.appending("[IMAGE-DATA]")
        bodyString = bodyString.appending("\r\n")
        bodyString = bodyString.appending("--".appending(boundary.appending("--\r\n")))
        
        return body as Data
    }
    
}


extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

