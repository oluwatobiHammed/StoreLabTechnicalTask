//
//  ViewController.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 05/07/2023.
//

import UIKit

class ImageListViewController: BaseViewController {
    
    
    private lazy var imageListViewModel: ImageListViewModel = {
        return ImageListViewModel(setView: self, networkManager: NetworkManager())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageListViewModel.viewDidLoad()
        view.backgroundColor = .white
        errorTitle.text = "Oops!\nWe're busy building new imgae list!\n Be sure to check back soon."
        imageListViewModel.getImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func numberofImages(_ images: [ImageModel] = []) -> [ImageModel] {
        return imageListViewModel.imageListResult
    }
    
    override func pagination(index: Int) {
        imageListViewModel.pagination(index: index)
    }

}

extension ImageListViewController: ImageListViewProtocol {
    func reloadMovieTableView() {
        errorTitle.isHidden = (imageListViewModel.imageListResult.count > 0)
        imageListTableView.reloadData()
    }
    
    func showAlert(title: String?, message: String) {
        AlertManager.sharedAlertManager.showAlertWithTitle(title: title ?? "", message: message, controller: self)
    }
}

