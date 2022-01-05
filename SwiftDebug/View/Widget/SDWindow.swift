//
//  SDWindow.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import UIKit

class SDWindow: UIWindow {
    var preCenter: CGPoint = .zero
    static var sus: SDWindow = {
        let window = SDWindow(frame: .init(x: 0, y: mainBounds().height / 2, width: SDConfigCenter.shared.genernalConfig.susWidth, height: SDConfigCenter.shared.genernalConfig.susHeight))
        window.isHidden = false
        window.alpha = 1.0;
        window.backgroundColor = .clear
        window.windowLevel = UIWindow.Level.init(rawValue: 100)
        return window
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(drag)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func drag(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            preCenter = center
        case .changed:
            let trans = recognizer.translation(in: self)
            let x = preCenter.x + trans.x
            let y = preCenter.y + trans.y
            center = .init(x: x, y: y)
        case .ended, .cancelled:
            preCenter.y = center.y
            if center.x < mainBounds().width / 2 {
                if #available(iOS 11.0, *) {
                    preCenter.x = (UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0) + frame.width / 2
                } else {
                    preCenter.x = frame.width / 2
                }
            } else {
                preCenter.x = mainBounds().width - frame.width / 2
            }
            UIView.animate(withDuration: 0.25) {[unowned self] in
                center = preCenter
            }
            
        default:
            break
        }
    }
}
