////
////  SDCheckGroup.swift
////  SwiftDebug
////
////  Created by 林子鑫 on 2021/11/16.
////
//
//import Foundation
//import UIKit
//
//class SDCheckGroup: SDArrangedView {
//    var title: String = ""
//    var items: [String] = []
//    lazy var label: UILabel = {
//        let view = UILabel()
//        view.text = title
//        view.font = .systemFont(ofSize: 16)
//        view.textColor = mainTextColor
//        return view
//    }()
//
//    init(title: String, items: [String]) {
//        super.init(frame: .zero)
//        self.title = title
//        self.items = items
//        for item in items {
//            let checkbox = SDCheckbox()
//            checkbox.text = item
//            addSubview(checkbox)
//        }
//    }
//
//    override func layoutSubviews() {
//        label.text = title
//        let width = title.textWidth(font: label.font, height: frame.height)
//        label.frame.size.width = width + 5
//        var i = 0
//        for subview in subviews {
//            let width = items[i].textWidth(font: .systemFont(ofSize: 16), height: frame.height)
//            i = i + 1
//            subview.frame = .init(origin: .zero, size: .init(width: width + 30, height: frame.height))
//        }
//        super.layoutSubviews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
