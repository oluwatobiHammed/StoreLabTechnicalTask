//
//  FavoriteMoviesViewController.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 05/07/2023.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {
    
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return .darkContent
//    }
    
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
        errorTitle.isHidden = (imageListViewModel.numberofImages().count > 0)
    }
    
    override func numberofMovies(_ images: [ImageModel] = []) -> [ImageModel] {
        return imageListViewModel.numberofImages()
    }
}


extension FavoriteMoviesViewController: ImageListViewProtocol {
    func showAlert(title: String?, message: String) {
        
    }
    
    func reloadMovieTableView() {
        imageListTableView.reloadData()
    }
}
