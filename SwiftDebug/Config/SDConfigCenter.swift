//
//  SDConfigCenter.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/15.
//

import Foundation
class SDConfigCenter {
    static var shared: SDConfigCenter = SDConfigCenter()
    var isInstall = false   // 是否已经安装
    var enableGlobal: Bool = true // 全局开关
    var logConfig: SDLogConfig = SDLogConfig()  // 日志配置
    var netConfig: SDNetConfig = SDNetConfig()  // 网络配置
    var genernalConfig: SDGeneralConfig = SDGeneralConfig() // 通用配置
}
