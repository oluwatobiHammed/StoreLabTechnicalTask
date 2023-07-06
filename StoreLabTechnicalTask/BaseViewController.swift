//
//  BaseViewController.swift
//  StoreLabTechnicalTask
//
//  Created by Oluwatobi Oladipupo on 06/07/2023.
//

import UIKit


class BaseViewController: UIViewController {
    private let unavailableCellIdentifier = "UnavailableCellIdentifier"
    
    lazy var imageListTableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ImageDetailTableViewCell.self, forCellReuseIdentifier: ImageDetailTableViewCell.reuseIdentifier)
        $0.register(UITableViewCell.self, forCellReuseIdentifier: unavailableCellIdentifier)
        $0.separatorStyle = .none
        $0.backgroundColor = kColor.BrandColours.Bizarre
        $0.contentInsetAdjustmentBehavior = .never
        $0.keyboardDismissMode = .interactive
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
        $0.scrollIndicatorInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        $0.alwaysBounceVertical = true
        return $0
    }(UITableView())
    
    private let naVBarView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    var errorTitle: UILabel = {
        let label = UILabel()
        label.text = "Add favorite image here"
        label.textColor = kColor.BrandColours.DarkGray
        label.textAlignment = .center
        label.font = kFont.EffraRegular.of(size: 16)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpview()
    }
    
    
    // MARK: setUpview
    private func setUpview() {
        let icon = UIImage(named: .imagePlaceholder)
        let centerImageTitleView  = centerImageTitleView(icon: icon, subTitle: "Millions of movies TV shows and people to discover")
        view.addSubview(naVBarView)
        naVBarView.addSubview(centerImageTitleView)
        
        centerImageTitleView.snp.makeConstraints { make in
            make.top.equalTo(naVBarView.snp.top).inset(-50)
            make.left.equalTo(naVBarView.snp.left)
            make.right.equalTo(naVBarView.snp.right)
            make.bottom.equalTo(naVBarView.snp.bottom).offset(-5)
        }
        
        naVBarView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(imageListTableView)
        imageListTableView.snp.makeConstraints { make in
            make.top.equalTo(naVBarView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageListTableView.addSubview(errorTitle)
        errorTitle.snp.makeConstraints { make in
            make.center.equalTo(imageListTableView.snp.center)
        }
    }
    
    // MARK: Title and Image Navbar view
    private func centerImageTitleView(icon: UIImage, subTitle: String) -> UIView {
        
        let titleView = UIView()
        
        let imageIcon: UIImageView = {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            return $0
        }(UIImageView())
        
        let subTitleLabel: UILabel = {
            $0.font = kFont.EffraMediumRegular.of(size: 14)
            $0.textAlignment = .center
            $0.textColor = kColor.BrandColours.DarkGray.withAlphaComponent(0.6)
            return $0
        }(UILabel())
        
        imageIcon.image = icon
        subTitleLabel.text = subTitle

        lazy var  containerStackView: UIStackView = {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 4
            $0.isUserInteractionEnabled = true
            return $0
        }(UIStackView(arrangedSubviews: [imageIcon, subTitleLabel]))
        
        imageIcon.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        titleView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.center.equalTo(titleView.snp.center)
        }
        
        return titleView
        
    }
    
    func pagination(index: Int) {}
    
    private func navigationToDetailVC(image: ImageModel) {
        let imageDetailVC = ImageDetailsViewController(image: image)
        imageDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(imageDetailVC, animated: true)
    }
    
    func numberofMovies(_ images: [ImageModel] = []) -> [ImageModel]{
      return images
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension BaseViewController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  numberofMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailTableViewCell.reuseIdentifier, for: indexPath) as? ImageDetailTableViewCell {
            cell.setUpImage(imageobject: numberofMovies()[indexPath.row])
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: unavailableCellIdentifier, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pagination(index: indexPath.row)
       
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationToDetailVC(image: numberofMovies()[indexPath.row])
    }
}
