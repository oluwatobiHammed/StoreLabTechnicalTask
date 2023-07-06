//
//  ManagerProtocol.swift
//  MovieExplorer
//
//  Created by Oluwatobi Oladipupo on 11/06/2023.
//

import Foundation

protocol ManagerProtocol {
    func getImageList(page: Int, limit: Int, completion: @escaping (ApiResults<[ImageModel]>) -> Void )

}
