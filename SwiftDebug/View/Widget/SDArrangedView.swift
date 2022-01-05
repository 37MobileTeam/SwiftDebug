////
////  SDArrangedView.swift
////  SwiftDebug
////
////  Created by 林子鑫 on 2021/11/11.
////
//
//import Foundation
//import UIKit
//
//class SDArrangedView: UIView {
//    var arrangedX: CGFloat = 0
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        arrangedX = 0
//        for subview in subviews {
//            subview.frame.origin.x = arrangedX
//            arrangedX = arrangedX + subview.frame.width
//        }
//        frame.size.width = arrangedX
//    }
//}
