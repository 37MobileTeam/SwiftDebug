//
//  SDNavView.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit
class SDNavController: UINavigationController {
    override func viewDidLoad() {
        view.backgroundColor = .clear
        let navBarAppearance = self.navigationBar
        navBarAppearance.shadowImage = UIImage.init()
        navBarAppearance.setBackgroundImage(UIImage.init(), for: .default)
        //设置导航栏透明
        navBarAppearance.isTranslucent = true
        navBarAppearance.barTintColor = UIColor.white
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : SDConfigCenter.shared.genernalConfig.mainTextColor,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0)
        ]
        navBarAppearance.tintColor = SDConfigCenter.shared.genernalConfig.mainTextColor;
        self.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
}
