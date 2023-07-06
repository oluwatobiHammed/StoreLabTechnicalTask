//
//  ImageListViewModel.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

class ImageListViewModel {
    
    weak var view : ImageListViewProtocol?
    private var networkManager: ManagerProtocol
    private var imageListResult: [ImageModel] = []
    private var sendButtonPressed: Bool = false
    private var currentPage = 1
    
    
    init(setView view: ImageListViewProtocol?, networkManager: ManagerProtocol) {
        if let view  { self.view = view }
        self.networkManager = networkManager
    }
}


extension ImageListViewModel: ImageListProtocol {
    func numberofImages() -> [ImageModel] {
        imageListResult
    }
    
    func getImages() {
        networkManager.getImageList(page: currentPage, limit: 30) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let images):
                if currentPage == 1 {
                    imageListResult.removeAll()
                }
                if imageListResult.count  < 1 {
                    imageListResult = images
                } else {
                    imageListResult.append(contentsOf: images)
                }
                
                DispatchQueue.main.async { [self] in
                    ImageRealmManager.shared.updateOrSave(realmObject: images)
                    self.view?.reloadMovieTableView()
                }
            case .failure(let err):
                DispatchQueue.main.async { [self] in
                    self.view?.showAlert(title: "Something went wrong", message: err.localizedDescription)
                    self.getImagesLocally()
                }
                
            }
            
        }
        
    }
    
    func pagination(index: Int) {
        if   index == imageListResult.count - 1 {
            currentPage += 1
            getImages()
        }
    }
    
    func getImagesLocally() {
        if let images = ImageRealmManager.shared.images {
            imageListResult = images
            view?.reloadMovieTableView()
        }
    }
    
    func viewDidLoad() {
        addNotificationObserver()
    }
    
    
    private func addNotificationObserver() {
        // Favorite Movie update
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddedFavoriteImage), name: NSNotification.Name(rawValue: "updateAddedFavoriteImage"), object: nil)
    }
    
    @objc func updateAddedFavoriteImage() {
        view?.reloadMovieTableView()
    }
    
}
