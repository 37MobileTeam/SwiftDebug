//
//  Tool.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit
func mainBounds() ->CGRect {
    return UIScreen.main.bounds
}
extension UIColor {
    /// rgba创建UIColor
    convenience init(rgba: String) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let scanner = Scanner(string: rgba)
        var hexValue: CUnsignedLongLong = 0

        if scanner.scanHexInt64(&hexValue) {
            let length = rgba.count

            switch length {
            case 3:
                r = CGFloat((hexValue & 0xF00) >> 8)    / 15.0
                g = CGFloat((hexValue & 0x0F0) >> 4)    / 15.0
                b = CGFloat(hexValue & 0x00F)           / 15.0
            case 4:
                r = CGFloat((hexValue & 0xF000) >> 12)  / 15.0
                g = CGFloat((hexValue & 0x0F00) >> 8)   / 15.0
                b  = CGFloat((hexValue & 0x00F0) >> 4)  / 15.0
                a = CGFloat(hexValue & 0x000F)          / 15.0
            case 6:
                r = CGFloat((hexValue & 0xFF0000) >> 16)    / 255.0
                g = CGFloat((hexValue & 0x00FF00) >> 8)     / 255.0
                b  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                r = CGFloat((hexValue & 0xFF000000) >> 24)  / 255.0
                g = CGFloat((hexValue & 0x00FF0000) >> 16)  / 255.0
                b = CGFloat((hexValue & 0x0000FF00) >> 8)   / 255.0
                a = CGFloat(hexValue & 0x000000FF)          / 255.0
            default:
                print("Invalid number of values (\(length)) in HEX string. Make sure to enter 3, 4, 6 or 8 values. E.g. `aabbccff`")
            }

        } else {
            print("Invalid HEX value: \(rgba)")
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension Bundle {
    static var SDK: Bundle {
        return Bundle(path: main.bundlePath + "/SDKImages.bundle") ?? Bundle(for: SwiftDebug.self)
    }
}


extension Date {
    var time: String {
        let fmt = DateFormatter()
        fmt.dateFormat = "HH:mm:ss"
        return fmt.string(from: self)
    }
}

extension String {
    // 计算文本需要的长宽
    // swiftlint:disable line_length
    func textWidth(font: UIFont, height: CGFloat) -> CGFloat {
        return self.boundingRect(with: .init(width: CGFloat.infinity, height: height), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil).size.width
    }
    // swiftlint:disable line_length
    func textHeight(font: UIFont, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: .init(width: width, height: CGFloat.infinity), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil).size.height
    }
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    var content: String = ""
    if items.count == 1, let item = items.first {
        content = String(describing: item)
    } else if items.count > 1 {
        for item in items.dropFirst() {
            content.append("\(separator)\(item)")
        }
    }
    Swift.print(content)
    SwiftDebug.log(title: "---", content: content)
}
