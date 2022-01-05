////
////  SDRadioGroupView.swift
////  SwiftDebug
////
////  Created by 林子鑫 on 2021/11/16.
////
//
//import Foundation
//import UIKit
//
//class SDRadioGroupView: UIView {
//    let diameter: CGFloat = 18
//    let selectedColor: UIColor = logHeaderBgColor
//    private var radioView: [(LTHRadioButton, UILabel)] = []
//    var title: String = ""
//    lazy var label: UILabel = {
//        let view = UILabel()
//        view.textColor = .white
//        view.font = .systemFont(ofSize: 14)
//        return view
//    }()
//    var selectBlock: ((_ value: String) -> Void)?
//    private var selectTitle: String = "" {
//        didSet {
//            if oldValue != selectTitle {
//                selectBlock?(selectTitle)
//            }
//        }
//    }
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
//
//    func add(_ title: String) {
//        let radio = LTHRadioButton(diameter: diameter, selectedColor: selectedColor, deselectedColor: nil)
//        radio.translatesAutoresizingMaskIntoConstraints = false
//        let label = UILabel()
//        label.text = title
//        label.textColor = mainTextColor
//        label.font = .systemFont(ofSize: 14)
//        radioView.append((radio,label))
//        radio.onSelect {
//            self.selectTitle = title
//        }
//        let view = UIView()
//        view.addSubview(radio)
//        view.addSubview(label)
//        label.sizeToFit()
//        stackView.addArrangedSubview(view)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(stackView)
//        addSubview(label)
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        label.text = title
//        label.frame = .init(x: 20, y: 0, width: 40, height: frame.height)
//        stackView.frame = .init(x: label.frame.maxX, y: 0, width: frame.width - label.frame.maxX, height: frame.height)
//        for radio in radioView {
//            radio.0.frame = .init(x: 0, y: (frame.height - diameter) / 2, width: 20, height: frame.height)
//            radio.1.frame = .init(x: 20, y: 0, width: radio.1.frame.width, height: frame.height)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//}
