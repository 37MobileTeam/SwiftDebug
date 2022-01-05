//
//  SDSuspenedVC.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

class SDSuspendedView: UIView {
    var backgroundImage: UIImage? = UIImage(named: "icon", in: Bundle.SDK, compatibleWith: nil)
    let width: CGFloat = SDConfigCenter.shared.genernalConfig.susWidth
    let height: CGFloat = SDConfigCenter.shared.genernalConfig.susHeight
    var showFuncList: Bool = false
    var funcListWindow: SDWindow?
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = backgroundImage
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        addSubview(imageView)
        imageView.frame = bounds
        imageView.layer.cornerRadius = width / 2
        imageView.layer.masksToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggle)))
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if imageView.frame.contains(point) {
            return imageView
        }
        return nil
    }
    
    @objc func toggle() {
        if !showFuncList {
            if funcListWindow == nil {
                let mainBounds = mainBounds()
                let xOffset: CGFloat
                if #available(iOS 11.0, *) {
                    xOffset = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
                } else {
                    xOffset = 0
                }
                if mainBounds.width < mainBounds.height {
                    funcListWindow = SDWindow(frame: .init(x: xOffset, y: 100, width: mainBounds.width, height: mainBounds.height / 3))
                } else {
                    funcListWindow = SDWindow(frame: .init(x: xOffset, y: 0, width: mainBounds.width / 2, height: mainBounds.height))
                }
                
                funcListWindow!.layer.cornerRadius = 8
                funcListWindow!.isHidden = false
                funcListWindow!.alpha = 1.0;
                funcListWindow!.backgroundColor = .clear
                let navController = SDNavController(rootViewController: SDFunListViewController())
                funcListWindow!.rootViewController = navController
            } else {
                funcListWindow?.isHidden = false
            }
        } else {
            funcListWindow?.isHidden = true
        }
        showFuncList = !showFuncList
    }
}
