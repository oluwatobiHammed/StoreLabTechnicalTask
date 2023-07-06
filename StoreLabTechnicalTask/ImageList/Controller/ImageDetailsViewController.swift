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
    private var starsRating: Int?
    private var listOfLikedImages =  UserManager().readLikedImage()
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
//    private let mainContentContainer: UIView = {
//        $0.backgroundColor = UIColor(hexString: "#A4000000", alpha: 0.1)
//        $0.isOpaque = false
//        return $0
//    }(UIView(frame: .zero))
//
//    private let contentContainer: UIView = {
//        $0.backgroundColor = .clear
//        return $0
//    }(UIView(frame: .zero))
//
//    private let topcontentContainer: UIView = {
//        $0.backgroundColor = .clear
//        return $0
//    }( UIView(frame: .zero))
//
//    private let firstLineViewContainer: UIView = {
//        $0.backgroundColor =  kColor.BrandColours.DarkGray
//        return $0
//    }(UIView(frame: .zero))
//
//    private let secondLineViewContainer: UIView = {
//        $0.backgroundColor =  kColor.BrandColours.DarkGray
//        return $0
//    }(UIView(frame: .zero))
    
//    private let rateLabel: UILabel = {
//        $0.font = kFont.EffraMediumRegular.of(size: 18)
//        $0.textAlignment = .left
//        $0.numberOfLines = 0
//        $0.textColor = kColor.BrandColours.DarkGray
//        return $0
//    }(UILabel())
//
//    private let overViewLabel: UILabel = {
//        $0.font = kFont.EffraRegular.of(size: 14)
//        $0.textAlignment = .center
//        $0.numberOfLines = 0
//        $0.textColor = kColor.BrandColours.DarkGray
//        $0.adjustsFontForContentSizeCategory = true
//        $0.minimumScaleFactor = 0.4
//        $0.adjustsFontSizeToFitWidth = true
//        $0.sizeToFit()
//        return $0
//    }(UILabel())
//
//    private let releasedateTitleLabel: UILabel = {
//        $0.font = kFont.EffraRegular.of(size: 12)
//        $0.text = "Release Date"
//        $0.textAlignment = .left
//        $0.numberOfLines = 0
//        $0.textColor = kColor.BrandColours.DarkGray.withAlphaComponent(0.5)
//        return $0
//    }(UILabel())
//
//    private let releasedateLabel: UILabel = {
//        $0.font = kFont.EffraHeavyRegular.of(size: 14)
//        $0.textAlignment = .left
//        $0.numberOfLines = 2
//        $0.textColor = kColor.BrandColours.DarkGray
//        return $0
//    }(UILabel())
//
//
//    private lazy var containerStackView: UIStackView = {
//        $0.axis = .vertical
//        $0.distribution = .fillEqually
//        $0.backgroundColor = .clear
//        $0.alignment = .fill
//        return $0
//    }(UIStackView(arrangedSubviews: [topcontentContainer, contentContainer]))
//
//    private lazy var releaseDatecontainerStackView: UIStackView = {
//        $0.axis = .vertical
//        $0.distribution = .fillEqually
//        $0.backgroundColor = .clear
//        $0.alignment = .fill
//        $0.spacing = -60
//        return $0
//    }(UIStackView(arrangedSubviews: [releasedateTitleLabel, releasedateLabel]))
//
//
//    private let circleImage: UIImageView = {
//        let image = UIImage(named: .circle).imageWithColor(tintColor: UIColor.hexString("FFCA28"))
//        $0.contentMode = .scaleAspectFit
//        $0.image = image
//        $0.clipsToBounds = true
//        return $0
//    }(UIImageView())
//
//    private let ratingbuttonsStackView: UIStackView = {
//        $0.axis = .horizontal
//        $0.distribution = .fillEqually
//        $0.alignment = .fill
//        $0.spacing = 5
//        $0.isUserInteractionEnabled = true
//        return $0
//    }(UIStackView(frame: .zero))
    
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
    
    
//    private lazy var moviedetailsViewViewModel: DetailMovieViewModelProtocol = {
//        return DetailMovieViewModel(setView: self, networkManager: networkManager)
//    }()
    
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
            make.center.equalToSuperview()
        }
        heightConstraint = posterImage.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
        view.addSubview(overLayView)
        overLayView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.left)
            make.right.equalTo(posterImage.snp.right)
            make.width.equalTo(posterImage.snp.width)
        }
        
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(view.snp.left).offset(15)
            make.bottom.equalTo(view.snp.bottom).offset(-35)
        }
        
        view.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.right.equalTo(view.snp.right).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-35)
        }
        
        
    }
    
    @objc private func likedButtonnPressed() {
        isfavorite = !isfavorite
        guard let id = image.id else {return}
        if isfavorite {
            listOfLikedImages.append(id)
        } else {
            guard let index = listOfLikedImages.firstIndex(where: {$0 == id }) else {return}
            listOfLikedImages.remove(at: index)
        }
        UserManager().setLikedImage(listOfLikedImages)
        likeButton.setImage(likebuttonimage.imageWithColor(tintColor: isfavorite ? .red : .white), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAddedFavoriteImage") , object: nil)
        
    }
    
    @objc private func shareButtonnPressed() {
        guard let shareAll = [posterImage.image] as? [Any] else {return}
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

//extension ImageDetailsViewController: DetailMovieViewProtocol {
//    func updateLikeButton(isfavorite: Bool) {
//        likeButton.setImage(likebuttonimage.imageWithColor(tintColor: isfavorite ? .red : .white), for: .normal)
//    }
//
//    func showAlert(title: String?, message: String) {
//        AlertManager.sharedAlertManager.showAlertWithTitle(title: title ?? "", message: message, controller: self)
//    }
//
//}
