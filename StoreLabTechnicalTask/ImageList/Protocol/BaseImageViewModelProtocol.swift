//
//  BaseImageViewModelProtocol.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

protocol BaseImageViewModelProtocol {
    func numberofImages() -> [ImageModel]
    func getImages()
    func viewDidLoad()
}

