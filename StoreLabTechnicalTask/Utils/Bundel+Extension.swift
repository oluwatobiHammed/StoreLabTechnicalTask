//
//  Bundel+Extension.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 07/07/2023.
//

import Foundation


extension Bundle {
    func decodeJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let decodedObject = try  type.decode(data: data)
                return decodedObject
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found: \(fileName).json")
        }
        return nil
    }
}
