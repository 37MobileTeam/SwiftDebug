//
//  SDCPUView.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/19.
//

import Foundation
class SDCPUView: SDPerformGridView {
    var cores: Int = 0 {
        didSet {
            desc = "CPU核心数: \(cores)\nCPU使用率: \(used)%"
        }
    }
    var used: Float = 0 {
        didSet {
            desc = "CPU核心数: \(cores)\nCPU使用率: \(used)%"
        }
    }
    
    convenience init() {
        self.init(title: "CPU", desc: "CPU使用率: x%")
    }
}
