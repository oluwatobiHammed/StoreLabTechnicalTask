//
//  BaseProtocol.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

protocol ImageListProtocol: BaseImageViewModelProtocol {
    func pagination(index: Int)
    func viewDidLoad()
}
