//
//  SDPerformGridViwe.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/19.
//

import Foundation
import UIKit

class SDPerformGridView: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var desc: String = "" {
        didSet {
            descLabel.text = desc
        }
    }
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: 15, width: frame.width, height: 20))
        view.text = title
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    
    lazy var descLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: 50, width: frame.width, height: frame.height - 50))
        view.textAlignment = .center
        view.textColor = .white
        view.text = desc
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    private func loadView() {
        backgroundColor = .black
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
        addSubview(titleLabel)
        addSubview(descLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            descLabel.widthAnchor.constraint(equalTo: widthAnchor),
            descLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25),
            descLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 25)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    required init(frame: CGRect, title: String, desc: String) {
        super.init(frame: frame)
        self.title = title
        self.desc = desc
        loadView()
    }
    
    convenience init(title: String, desc: String) {
        self.init(frame: .zero, title: title, desc: desc)
    }
}
