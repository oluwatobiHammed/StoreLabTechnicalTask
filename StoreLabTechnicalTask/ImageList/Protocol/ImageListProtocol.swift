//
//  BaseProtocol.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

protocol ImageListProtocol {
    func numberofImages() -> [ImageModel]
    func getImages()
    func pagination(index: Int)
    func viewDidLoad()
}
