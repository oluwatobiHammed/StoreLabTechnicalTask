//
//  BaseImageViewModelProtocol.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

protocol BaseImageViewModelProtocol {
    var imageListResult: [ImageModel] { get set }
    func getImages()
    func viewDidLoad()
}

