////
////  SDCheckbox.swift
////  SwiftDebug
////
////  Created by 林子鑫 on 2021/11/16.
////
//
//import Foundation
//import UIKit
//
//class SDCheckbox: UIView {
//    let boxWidth: CGFloat = 25
//    let boxHeight: CGFloat = 25
//    var text = "" {
//        didSet {
//            label.text = text
//        }
//    }
//    lazy var label: UILabel = {
//        let label = UILabel()
//        label.text = text
//        label.textColor = mainTextColor
//        label.font = .systemFont(ofSize: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    lazy var checkbox: Checkbox = {
//        let checkbox = Checkbox(frame: .init(x: 0, y: 0, width: boxWidth, height: boxHeight))
//        checkbox.checkedBorderColor = logHeaderBgColor
//        checkbox.uncheckedBorderColor = logHeaderBgColor
//        checkbox.checkmarkColor = .blue
//        checkbox.checkmarkStyle = .square
//        checkbox.translatesAutoresizingMaskIntoConstraints = false
//        return checkbox
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//
//    private func setupUI() {
//        addSubview(checkbox)
//        addSubview(label)
//        label.text = text
//        NSLayoutConstraint.activate([
//            checkbox.leftAnchor.constraint(equalTo: leftAnchor),
//            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
//            checkbox.widthAnchor.constraint(equalToConstant: boxWidth),
//            checkbox.heightAnchor.constraint(equalToConstant: boxHeight),
//            label.leftAnchor.constraint(equalTo: checkbox.rightAnchor, constant: 5),
//            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.heightAnchor.constraint(equalTo: heightAnchor),
//            label.widthAnchor.constraint(equalTo: widthAnchor, constant:  -boxWidth - 5)
//        ])
//    }
//}
