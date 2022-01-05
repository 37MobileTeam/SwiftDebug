//
//  SDView.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

class SDView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for v in subviews {
            if v.frame.contains(point) {
                return super.hitTest(point, with: event)
            }
        }
        return nil
    }
}
