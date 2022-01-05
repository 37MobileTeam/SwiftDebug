//
//  SDFunListCell.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

/// 首页功能列表Cell
class SDFuncListCell: UICollectionViewCell {
    private var image: UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
            }
        }
    }
    private var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = image
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = title
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        addConstraints()
    }
    
    init() {
        super.init(frame: .init(origin: .zero, size: .init(width: SDConfigCenter.shared.genernalConfig.funcListCellWidth, height: SDConfigCenter.shared.genernalConfig.funcListCellHeigth)))
        loadView()
        addConstraints()
    }
    
    private func loadView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
        ])
    }
    
    func update(image: UIImage?, title: String) {
        self.image = image
        self.title = title
    }
}
