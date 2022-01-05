//
//  Constant.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

/*
    全局界面配置
 */
let mainBackgroundColor: UIColor = UIColor(rgba: "F8F8FF").withAlphaComponent(0.85)   // 主背景色
let mainTextColor: UIColor = .darkGray      // 主文本颜色
let funcListCellWidth: CGFloat = 64         // 功能列表Cell宽度
let funcListCellHeigth: CGFloat = 64        // 功能列表Cell高度
let navHeight: CGFloat = 44                 // 导航栏高度
let navBackgoundColor: UIColor = UIColor(rgba: "1E90FF").withAlphaComponent(0.85)
let navTextColor: UIColor = UIColor.white   // 导航栏字体颜色


/*
    悬浮球配置
 */
let susWidth: CGFloat = 44
let susHeight: CGFloat = 44

/*
  日志界面配置
 */
let logOptHeight: CGFloat = 36              // 日志搜索栏高度
let logOrderWidth: CGFloat = 40             // 日志Cell序号宽度
let logLevelWidth: CGFloat = 40             // 日志Cell级别宽度
let logTimeWidth: CGFloat = 70              // 日志Cell时间宽度
let logTypeWidth: CGFloat = 60              // 日志Cell类型宽度
let logTitleWidth: CGFloat = 100             // 日志Cell标题宽度
let logContentWidth: CGFloat = 280       // 日志Cell内容宽度
let logCellFont: UIFont = UIFont.systemFont(ofSize: 14) // 日志Cell字体
let logHeaderFont: UIFont = UIFont.boldSystemFont(ofSize: 17)   // 日志标题字体
let logHeaderHeight: CGFloat = 32           // 日志Cell标题栏高度
let logHeaderBgColor: UIColor = UIColor(rgba: "87CEEB")  // 日志Cell标题栏背景色
let logInfoTextColor: UIColor = UIColor(white: 0.8, alpha: 1.0)  // info日志颜色
let logWarnTextColor: UIColor = .orange     // warn日志颜色
let logErrorTextColor: UIColor = .red       // error日志颜色
