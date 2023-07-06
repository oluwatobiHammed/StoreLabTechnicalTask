//
//  ImageListViewProtocol.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

protocol ImageListViewProtocol: AnyObject {
    func showAlert(title: String?, message: String)
    func reloadMovieTableView()
}
