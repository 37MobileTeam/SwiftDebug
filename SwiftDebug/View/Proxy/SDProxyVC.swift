//
//  SDProxyVC.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/15.
//

import Foundation
import UIKit


// 代理网络界面
class SDProxyVC: SDViewController {
    let labelWidth: CGFloat = 80
    let viewHeight: CGFloat = 40
    let lineSpacing: CGFloat = 20
    lazy var enableLabel: UILabel = {
        let view = UILabel()
        view.text = "是否启用"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: 30, y: lineSpacing + navOffset, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var enableSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = SDConfigCenter.shared.netConfig.enableNetProxy
        view.frame = .init(x: 30 + labelWidth, y: lineSpacing + navOffset, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return view
    }()
    
    lazy var ipLabel: UILabel = {
        let view = UILabel()
        view.text = "ip地址"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: 30, y: lineSpacing + viewHeight + navOffset + lineSpacing, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var ipTF: SDAutoCompleteTextField = {
        let view = SDAutoCompleteTextField()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: viewHeight))
        view.leftView = leftView
        view.leftViewMode = .always
        view.text = SDConfigCenter.shared.netConfig.netIp
        view.frame = .init(x: 30 + labelWidth, y: lineSpacing + viewHeight + navOffset + lineSpacing, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.keyboardType = .decimalPad
        view.autoCompleteStrings = SDConfigCenter.shared.netConfig.netIpHistory
        return view
    }()
    
    lazy var portLabel: UILabel = {
        let view = UILabel()
        view.text = "端口地址"
        view.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        view.frame = .init(x: 30, y: (lineSpacing + viewHeight) * 2 + navOffset + lineSpacing, width: labelWidth, height: viewHeight)
        return view
    }()
    
    lazy var portTF: SDAutoCompleteTextField = {
        let view = SDAutoCompleteTextField()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.text = String(SDConfigCenter.shared.netConfig.netPort)
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: viewHeight))
        view.leftView = leftView
        view.leftViewMode = .always
        view.keyboardType = .numberPad
        view.frame = .init(x: 30 + labelWidth, y: (lineSpacing + viewHeight) * 2 + navOffset + lineSpacing, width: self.view.frame.width - 60 - labelWidth, height: viewHeight)
        view.autoCompleteStrings = SDConfigCenter.shared.netConfig.netPortHistory.map({String($0)})
        return view
    }()
    
    lazy var submitBtn: UIButton = {
        let view = UIButton()
        view.setTitle("确定", for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = SDConfigCenter.shared.genernalConfig.navBackgoundColor
        view.frame = .init(x: self.view.frame.width / 2 - 50, y: (lineSpacing + viewHeight) * 3 + navOffset + lineSpacing, width: 100, height: viewHeight)
        view.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(enableLabel)
        view.addSubview(enableSwitch)
        view.addSubview(ipLabel)
        view.addSubview(ipTF)
        view.addSubview(portTF)
        view.addSubview(portLabel)
        view.addSubview(submitBtn)
        ipTF.spView = view
        portTF.spView = view
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEdit)))
    }
    
    @objc func submitAction() {
        let ip = ipTF.text ?? ""
        let port = portTF.text ?? ""
        SwiftDebug.setNetProxy(ip: ip, port: port)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func switchAction() {
        SDConfigCenter.shared.netConfig.enableNetProxy = enableSwitch.isOn
    }
    
    @objc func stopEdit() {
        view.endEditing(true)
    }
}
