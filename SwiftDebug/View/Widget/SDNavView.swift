//
//  SDNavView.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

// 自己实现导航栏
class SDNavView: UIView {
    var title: String = "标题"
    var backImg: UIImage?
    let backTitle: String = "返回"
    var enableBack: Bool = false
    var backCallback: () -> Void = {}
    var y: CGFloat = 0
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = title
        view.textColor = SDConfigCenter.shared.genernalConfig.navTextColor
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setTitle(backTitle, for: .normal)
        view.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.setTitleColor(SDConfigCenter.shared.genernalConfig.navTextColor, for: .normal)
        let img = UIImage(named: "back24", in: Bundle.SDK, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        view.titleLabel?.font = .systemFont(ofSize: 17)
        view.setImage(img, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    init(frame:CGRect, title: String, withBack: Bool = false, backCallback: @escaping ()-> Void) {
        self.title = title
        enableBack = withBack
        self.backCallback = backCallback
        super.init(frame: frame)
        loadView()
    }
    
    @objc func backAction() {
        backCallback()
    }
    
    func loadView() {
        backgroundColor = SDConfigCenter.shared.genernalConfig.navBackgoundColor
        if enableBack {
            addSubview(backButton)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backButton.widthAnchor.constraint(equalToConstant: 100),
                backButton.heightAnchor.constraint(equalToConstant: SDConfigCenter.shared.genernalConfig.navHeight),
                backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                backButton.leftAnchor.constraint(equalTo: leftAnchor),
            ])
        }
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
