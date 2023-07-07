//
//  FavoriteImageViewModel.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import Foundation

class FavoriteImageViewModel {
    
    weak var view : ImageListViewProtocol?
    private var listOfLikedImages: [String] = []
    private var imageListResult: [ImageModel] = []
    init(setView view: ImageListViewProtocol?) {
        if let view  { self.view = view }
    }
    
}

extension FavoriteImageViewModel: BaseImageViewModelProtocol {
    
    func getImages() {
        imageListResult.removeAll()
        listOfLikedImages = UserManager().readLikedImage()
        if let localImages = ImageRealmManager.shared.images {
            listOfLikedImages.forEach { id in
                if let img = localImages.first(where: {$0.id == id })  {
                    imageListResult.append(img)
                }
            }
        }
    }
    
    func numberofImages() -> [ImageModel] {
        imageListResult
    }
    
    
    func viewDidLoad() {
        addNotificationObserver()
    }
    
    
    private func addNotificationObserver() {
        // Favorite Image update
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddedFavoriteImage), name: NSNotification.Name(rawValue: "updateAddedFavoriteImage"), object: nil)
    }
    
    @objc func updateAddedFavoriteImage() {
        getImages()
        view?.reloadMovieTableView()
    }
    
}
