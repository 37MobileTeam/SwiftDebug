//
//  SwiftDebug.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit
@objcMembers public class SwiftDebug: NSObject {
    static let addLogNotification = "SDAddLogNotification"
    static let refreshLogNotification = "SDRefreshLogNotification"
    public static func install() {
        if SDConfigCenter.shared.isInstall {
            return
        }
        let window = SDWindow.sus
        let vc = SDViewController()
        vc.view.backgroundColor = .clear
        vc.view.addSubview(SDSuspendedView())
        window.rootViewController = vc
        startMonitor()
        SDConfigCenter.shared.isInstall = true
        
    }
    
    /// 开启网络监控和代理服务
    public static func startMonitor() {
        SDURLProtocol.startMonitor()
    }
    
    /// 日志记录
    public static func log(level: SDLogLevel = SDLogLevel.info, type: SDLogType = SDLogType.undefined, title: String, content: String) {
        if !SDConfigCenter.shared.enableGlobal {
            return
        }
        if !SDConfigCenter.shared.logConfig.enablePrintLog, type == .print {
            return
        }
        if !SDConfigCenter.shared.logConfig.enableNetLog, type == .network {
            return
        }
        let t = Date().time
        let log = SDLogModel(id: t.replacingOccurrences(of: ":", with: ""), level: level, time: t, type: type, title: title, content: content)
        SDDataCenter.shared.logs.append(log)
        do {
            var file = try SDFileManager.shared.getFile(SDConstant.logFilePath)
            file.appendFlush(log.jsonString)
        } catch {
            
        }
        NotificationCenter.default.post(name: Notification.Name(addLogNotification), object: log)
    }
    
    /// 记录网络的
    public static func logNet(level: SDLogLevel = SDLogLevel.info, title: String, content: String) {
        log(level:level, type: SDLogType.network, title:title, content: content)
    }
    
    /// 设置网络代理
    public static func setNetProxy(ip: String, port: String) {
        SDConfigCenter.shared.netConfig.netIp = ip
        SDConfigCenter.shared.netConfig.netPort = port
    }
}
