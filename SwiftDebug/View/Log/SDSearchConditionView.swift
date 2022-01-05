////
////  SDSearchConditionView.swift
////  SwiftDebug
////
////  Created by 林子鑫 on 2021/11/16.
////
//
//import Foundation
//import UIKit
//
//class SDSearchConditionView: UIView {
//    lazy var levelCheckbox: SDCheckGroup = {
//        let view = SDCheckGroup(title: "级别", items: ["Info", "Warn", "Error"])
//        return view
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
//        levelCheckbox.frame = .init(x: 0, y: 10, width: frame.width, height: 30)
//        addSubview(levelCheckbox)
//        backgroundColor = .blue.withAlphaComponent(0.75)
//    }
//}
