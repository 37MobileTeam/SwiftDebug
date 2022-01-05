//
//  SDSettingVC.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/17.
//

import Foundation
import UIKit

// 设置界面
class SDSettingVC: SDViewController {
    let labelWidth: CGFloat = 150
    let viewHeight: CGFloat = 40
    let lineSpacing: CGFloat = 20
    override var navTitle: String {
        return "设置"
    }
    private var xOffset: CGFloat {
        return (view.frame.width - labelWidth - 51) / 2
    }
    lazy var enableGlobalLabel: UILabel = {
        let view = UILabel()
        view.text = "是否启用(全局)"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: xOffset, y: lineSpacing + navOffset, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var enableGlobalSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = SDConfigCenter.shared.enableGlobal
        view.frame = .init(x: xOffset + labelWidth, y: lineSpacing + navOffset, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.addTarget(self, action: #selector(globalAction), for: .valueChanged)
        return view
    }()
    
    lazy var enableMonitorLabel: UILabel = {
        let view = UILabel()
        view.text = "是否开启网络监控"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: xOffset, y: lineSpacing + viewHeight + navOffset + lineSpacing, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var enableMonitorSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = SDConfigCenter.shared.netConfig.enableNetMonitor
        view.frame = .init(x: xOffset + labelWidth, y: lineSpacing + viewHeight + navOffset + lineSpacing, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.addTarget(self, action: #selector(monitorAction), for: .valueChanged)
        return view
    }()
    
    lazy var enablePrintLogLabel: UILabel = {
        let view = UILabel()
        view.text = "是否输出打印日志"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: xOffset, y: (lineSpacing + viewHeight) * 2 + navOffset + lineSpacing, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var enablePrintLogSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = SDConfigCenter.shared.logConfig.enablePrintLog
        view.frame = .init(x: xOffset + labelWidth, y: (lineSpacing + viewHeight) * 2 + navOffset + lineSpacing, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.addTarget(self, action: #selector(printLogAction), for: .valueChanged)
        return view
    }()
    
    lazy var enableNetLogLabel: UILabel = {
        let view = UILabel()
        view.text = "是否输出网络日志"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: xOffset, y: (lineSpacing + viewHeight) * 3 + navOffset + lineSpacing, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var enableNetLogSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = SDConfigCenter.shared.logConfig.enableNetLog
        view.frame = .init(x: xOffset + labelWidth, y: (lineSpacing + viewHeight) * 3 + navOffset + lineSpacing, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.addTarget(self, action: #selector(netLogAction), for: .valueChanged)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(enableGlobalLabel)
        view.addSubview(enableGlobalSwitch)
        view.addSubview(enableMonitorLabel)
        view.addSubview(enableMonitorSwitch)
        view.addSubview(enablePrintLogLabel)
        view.addSubview(enablePrintLogSwitch)
        view.addSubview(enableNetLogLabel)
        view.addSubview(enableNetLogSwitch)
    }
    
    @objc func globalAction() {
        SDConfigCenter.shared.enableGlobal = enableGlobalSwitch.isOn
        if SDConfigCenter.shared.enableGlobal, SDConfigCenter.shared.netConfig.enableNetMonitor {
            SDURLProtocol.startMonitor()
        } else {
            SDURLProtocol.stopMonitor()
        }
    }
    
    @objc func monitorAction() {
        SDConfigCenter.shared.netConfig.enableNetMonitor = enableMonitorSwitch.isOn
        if SDConfigCenter.shared.enableGlobal, SDConfigCenter.shared.netConfig.enableNetMonitor {
            SDURLProtocol.startMonitor()
        } else {
            SDURLProtocol.stopMonitor()
        }
    }
    @objc func printLogAction() {
        SDConfigCenter.shared.logConfig.enablePrintLog = enablePrintLogSwitch.isOn
    }
    @objc func netLogAction() {
        SDConfigCenter.shared.logConfig.enableNetLog = enableNetLogSwitch.isOn
    }
    
}
