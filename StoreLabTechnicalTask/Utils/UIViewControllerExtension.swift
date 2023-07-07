//
//  UIViewControllerExtension.swift
//  MovieExplorer
//
//  Created by Oluwatobi Oladipupo on 09/06/2023.
//

import UIKit

extension UIViewController {
    
    @objc func hideTabbar(isShown: Bool = true) -> Bool {
       return isShown
    }
}


extension UIViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if hideTabbar() { changeTabBar(hidden: scrollView.panGestureRecognizer.translation(in: scrollView).y < 0, animated: true) }
    }
    
    private func changeTabBar(hidden:Bool, animated: Bool) {
        
        let tabBar = self.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: { [self] in
            tabBar!.frame.origin.y = offset
            view.layoutIfNeeded()
        }, completion:nil)
    }
}
