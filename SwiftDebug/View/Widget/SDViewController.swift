//
//  SDViewController.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

/// 继承该类，添加视图的时候y坐标需要偏移navOffset
class SDViewController : UIViewController {
    var navOffset: CGFloat = 0
    var navTitle: String {
        "标题"
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = SDConfigCenter.shared.genernalConfig.mainBackgroundColor
        view.layer.cornerRadius = 8
        if let navController = navigationController {
            navController.isNavigationBarHidden = true
            navOffset = SDConfigCenter.shared.genernalConfig.navHeight
            let hasBack = navController.viewControllers.count > 1
            view.addSubview(SDNavView(frame: .init(x: 0, y: 0, width: view.frame.width, height: navOffset), title: navTitle, withBack: hasBack, backCallback: {
                self.navigationController?.popViewController(animated: true)
            }))
        }
    }
}
