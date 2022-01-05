//
//  SDMemoryView.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/19.
//

import Foundation
class SDMemoryView: SDPerformGridView {
    var unit: String = "GB"
    var used: Float = 0 {
        didSet { updateMemory() }
    }
    var all: Float = 0 {
        didSet { updateMemory() }
    }
    convenience init() {
        self.init(title: "内存", desc: "内存使用情况：x unit / y unit")
    }
    
    private func updateMemory() {
        desc = "内存使用情况：\(used) \(unit) / \(all) \(unit)"
    }
    
    func switchToMB() {
        if unit == "GB" {
            unit = "MB"
            used = used * 1024
            all = all * 1024
        }
    }
    
    func switchToGB() {
        if unit == "MB" {
            unit = "GB"
            used = used / 1024
            all = all / 1024
        }
    }
}
