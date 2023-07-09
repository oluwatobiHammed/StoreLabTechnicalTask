//
//  FavoriteMoviesViewController.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 05/07/2023.
//

import UIKit

class FavoriteImagesViewController: BaseViewController {
    
    private lazy var imageListViewModel: FavoriteImageViewModel = {
        return FavoriteImageViewModel(setView: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageListViewModel.viewDidLoad()
        imageListViewModel.getImages()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageListViewModel.getImages()
        errorTitle.isHidden = (imageListViewModel.imageListResult.count > 0)
    }
    
    override func numberofImages(_ images: [ImageModel] = []) -> [ImageModel] {
        return imageListViewModel.imageListResult
    }
}


extension FavoriteImagesViewController: ImageListViewProtocol {
    func showAlert(title: String?, message: String) {
        
    }
    
    func reloadMovieTableView() {
        imageListTableView.reloadData()
    }
}
