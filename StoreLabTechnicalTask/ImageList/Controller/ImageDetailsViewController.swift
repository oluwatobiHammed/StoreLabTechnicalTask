//
//  MovieDetailsViewController.swift
//  MovieExplorer
//
//  Created by Oluwatobi Oladipupo on 10/06/2023.
//

import UIKit
import Kingfisher

class ImageDetailsViewController: UIViewController {
    
    private var image: ImageModel
    private var listOfLikedImages = UserManager().readLikedImage()
    private let likebuttonimage = UIImage(named: .heartFill)
    private var isfavorite: Bool = false
    private var heightConstraint: NSLayoutConstraint?
    
    private let posterImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let overLayView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = kColor.BrandColours.DarkGray.withAlphaComponent(0.3)
        return view
    }()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .darkContent
    }
    
    private (set) lazy var likeButton: UIButton = {
        $0.addTarget(self, action: #selector(likedButtonnPressed), for: .touchUpInside)
        $0.imageView?.contentMode = .scaleAspectFit
        return $0
    }(UIButton())
    
    private (set) lazy var shareButton: UIButton = {
        let image = UIImage(named: .share)
        $0.addTarget(self, action: #selector(shareButtonnPressed), for: .touchUpInside)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: .share), for: .normal)
        return $0
    }(UIButton())
    
    private lazy var ratingImages = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    
    init(image: ImageModel) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
        setUpPoster()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = kColor.BrandColours.Bizarre
        setUpview()
        
    }
    
    
    private func setUpPoster() {
        let defaultImage = UIImage(named: .imagePlaceholder)
        let imgUrl = image.download_url ?? ""
        posterImage.kf.setImage(with:URL(string: imgUrl),
                                placeholder: defaultImage,
                                options: [.loadDiskFileSynchronously,
                                          .cacheOriginalImage,
                                          .diskCacheExpiration(.days(7)),
                                          .transition(.fade(0.5))]) { _ in
                                              self.view.layoutIfNeeded()
                                          }
        heightConstraint?.constant = posterImage.image?.size.height ?? 0

        isfavorite = listOfLikedImages.contains(where: { $0 == image.id })
        likeButton.setImage( likebuttonimage.imageWithColor(tintColor: isfavorite ? .red : .white), for: .normal)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        posterImage.roundCorners([.topLeft, .topRight], radius: 20)
        overLayView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    
    private func setUpview() {
        
        view.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        heightConstraint?.isActive = true
        view.addSubview(overLayView)
        overLayView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.left)
            make.right.equalTo(posterImage.snp.right)
            make.width.equalTo(posterImage.snp.width)
        }
        
        heightConstraint = overLayView.heightAnchor.constraint(equalToConstant: 0)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(posterImage.snp.left).offset(15)
            make.bottom.equalTo(posterImage.snp.bottom).offset(-35)
        }
        
        view.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.right.equalTo(posterImage.snp.right).offset(-15)
            make.bottom.equalTo(posterImage.snp.bottom).offset(-35)
        }
        
        
    }
    
    @objc private func likedButtonnPressed() {
        isfavorite = !isfavorite
        guard let id = image.id else {return}
        if isfavorite {
            listOfLikedImages.append(id)
            UserManager().setLikedImage(listOfLikedImages)
        } else {
            guard let index = listOfLikedImages.firstIndex(where: {$0 == id }) else {return}
            listOfLikedImages.remove(at: index)
            UserManager().setLikedImage(listOfLikedImages)
        }
        
        likeButton.setImage(likebuttonimage.imageWithColor(tintColor: isfavorite ? .red : .white), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAddedFavoriteImage"), object: nil)
        
    }
    
    @objc private func shareButtonnPressed() {
        guard let shareAll = [posterImage.image] as? [Any] else {return}
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

