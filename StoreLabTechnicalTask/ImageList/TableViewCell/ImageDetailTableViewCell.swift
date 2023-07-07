//
//  ImageDetailTableViewCell.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import UIKit
import Kingfisher
import SnapKit

class ImageDetailTableViewCell:  UITableViewCell {
    
    static let reuseIdentifier = "ImageDetailTableViewCell"
    private var listOfLiked: [String] = []
    
    private let posterImage: UIImageView = {
        $0.contentMode = .scaleToFill
        $0.cornerRadiusLayer = 10
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let LikedImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let safeAreaView: UIView = {
        $0.backgroundColor = .white.withAlphaComponent(0.6)
        $0.cornerRadiusLayer = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.rasterizationScale = UIScreen.main.scale
        return $0
    }(UIView(frame: .zero))
    
    private let centeredTitleLabel: UILabel = {
        $0.font = kFont.EffraBold.of(size: 20)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let overViewTitleLabel: UILabel = {
        $0.font = kFont.EffraBold.of(size: 16)
        $0.textAlignment = .left
        $0.numberOfLines = 5
        $0.textColor = kColor.BrandColours.DarkGray.withAlphaComponent(0.8)
        return $0
    }(UILabel())
    
    private let overLayView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = kColor.BrandColours.DarkGray.withAlphaComponent(0.5)
        return view
    }()
    
  
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        clipsToBounds = true
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUpImage(imageobject: ImageModel) {
        
            let image = UIImage(named: .imagePlaceholder)
            let imgUrl = imageobject.download_url ?? ""
            posterImage.kf.setImage(with:URL(string: imgUrl),
                                    placeholder: image,
                                    options: [.loadDiskFileSynchronously,
                                              .cacheOriginalImage,
                                              .diskCacheExpiration(.days(7)),
                                              .transition(.fade(0.5))]) { _ in
                                                  self.layoutIfNeeded()
                                              }
            
        centeredTitleLabel.text = imageobject.author
        updateLikedImage(imageobject.id ?? "")
 
    }
    
    func updateLikedImage(_ id: String) {
            listOfLiked = UserManager().readLikedImage()
            let isfavorite = listOfLiked.contains(where: { $0 == id })
            let favoriteMovieLikeImage = UIImage(named: .heartFill).imageWithColor(tintColor: isfavorite ? .red : kColor.BrandColours.Bizarre)
            LikedImage.image = favoriteMovieLikeImage

    }
    
    private func setUpUI() {
     addSubview(safeAreaView)
        safeAreaView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        safeAreaView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.left.equalTo(safeAreaView.snp.left)
            make.right.equalTo(safeAreaView.snp.right)
            make.top.equalTo(safeAreaView.snp.top)
            make.bottom.equalTo(safeAreaView.snp.bottom)
        }
        
        safeAreaView.addSubview(overLayView)
        overLayView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.left)
            make.right.equalTo(posterImage.snp.right)
            make.top.equalTo(posterImage.snp.top)
            make.bottom.equalTo(posterImage.snp.bottom)
        }
        
        safeAreaView.addSubview(centeredTitleLabel)
        centeredTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(posterImage.snp.center)
      
        }
        
        safeAreaView.addSubview(LikedImage)
        LikedImage.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(40)
            make.right.equalTo(safeAreaView.snp.right).offset(-10)
            make.bottom.equalTo(safeAreaView.snp.bottom).offset(-10)
        }
        
    }
    

}

