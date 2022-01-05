//
//  Constant.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

struct SDConstant {
    static let netProxyEnableKey: String = "sd_net_proxy_enable"
    static let netIpCurrentKey: String = "sd_net_ip_current"
    static let netIpHistoryKey: String = "sd_net_port_history"
    static let netPortCurrentKey: String = "sd_net_port_current"
    static let netPortHistoryKey: String = "sd_net_port_history"
    static let logFilePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/SDLog.text")
}
