//
//  SDConfig.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/24.
//

import Foundation
import UIKit

struct SDLogConfig {
    /// 打印设置
    var enablePrintLog: Bool = true
    var enableNetLog: Bool = true
    var logOptHeight: CGFloat = 36              // 日志搜索栏高度
    var logOrderWidth: CGFloat = 40             // 日志Cell序号宽度
    var logLevelWidth: CGFloat = 40             // 日志Cell级别宽度
    var logTimeWidth: CGFloat = 70              // 日志Cell时间宽度
    var logTypeWidth: CGFloat = 60              // 日志Cell类型宽度
    var logTitleWidth: CGFloat = 100             // 日志Cell标题宽度
    var logContentWidth: CGFloat = 280       // 日志Cell内容宽度
    var logCellFont: UIFont = UIFont.systemFont(ofSize: 14) // 日志Cell字体
    var logHeaderFont: UIFont = UIFont.boldSystemFont(ofSize: 17)   // 日志标题字体
    var logHeaderHeight: CGFloat = 32           // 日志Cell标题栏高度
    var logHeaderBgColor: UIColor = UIColor(rgba: "87CEEB")  // 日志Cell标题栏背景色
    var logInfoTextColor: UIColor = UIColor(white: 0.8, alpha: 1.0)  // info日志颜色
    var logWarnTextColor: UIColor = .orange     // warn日志颜色
    var logErrorTextColor: UIColor = .red       // error日志颜色
}

struct SDNetConfig {
    // 网络请求监控
    var enableNetMonitor: Bool = true
    /// 网络代理
    var enableNetProxy: Bool {
        get {
            return SDKeyChain.queryBool(key: SDConstant.netProxyEnableKey)
        }
        set(newValue) {
            SDKeyChain.set(key: SDConstant.netProxyEnableKey, value: newValue)
        }
    }
    var netIp: String {
        get {
            return SDKeyChain.queryString(key: SDConstant.netIpCurrentKey)
        }
        set(newValue) {
            SDKeyChain.set(key: SDConstant.netIpCurrentKey, value: newValue)
            var all = netIpHistory
            if !all.contains(newValue){
                all.append(newValue)
                SDKeyChain.set(key: SDConstant.netIpHistoryKey, value: all)
            }
        }
    }
    var netPort: String {
        get {
            return SDKeyChain.queryString(key: SDConstant.netPortCurrentKey)
        }
        set(newValue) {
            SDKeyChain.set(key: SDConstant.netPortCurrentKey, value: newValue)
            var all = netPortHistory
            if !all.contains(newValue){
                all.append(newValue)
                SDKeyChain.set(key: SDConstant.netPortHistoryKey, value: all)
            }
        }
    }
    var netIpHistory: [String] {
        get {
            return SDKeyChain.queryArray(key: SDConstant.netIpHistoryKey)
        }
    }
    var netPortHistory: [String] {
        get {
            return SDKeyChain.queryArray(key: SDConstant.netIpHistoryKey)
        }
    }
}

struct SDGeneralConfig {
    var mainBackgroundColor: UIColor = UIColor(rgba: "F8F8FF").withAlphaComponent(0.85)   // 主背景色
    var mainTextColor: UIColor = .darkGray      // 主文本颜色
    var funcListCellWidth: CGFloat = 64         // 功能列表Cell宽度
    var funcListCellHeigth: CGFloat = 64        // 功能列表Cell高度
    var navHeight: CGFloat = 44                 // 导航栏高度
    var navBackgoundColor: UIColor = UIColor(rgba: "1E90FF").withAlphaComponent(0.85)
    var navTextColor: UIColor = UIColor.white   // 导航栏字体颜色
    //  悬浮球配置
    var susWidth: CGFloat = 44
    var susHeight: CGFloat = 44
}
