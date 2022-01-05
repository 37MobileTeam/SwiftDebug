//
//  SDPerformVC.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/19.
//

import Foundation
import UIKit
class SDPerformVC: SDViewController {
    override var navTitle: String { "性能监控" }
    private lazy var cpuView: SDCPUView = {
        let view = SDCPUView()
        view.cores = PerformMonitor.shared.cpuCore
        return view
    }()
    
    private lazy var memoryView: SDMemoryView = {
        let view = SDMemoryView()
        return view
    }()
    
    private lazy var netSpeedView: SDNetView = {
        let view = SDNetView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cpuView)
        view.addSubview(memoryView)
        view.addSubview(netSpeedView)
        cpuView.translatesAutoresizingMaskIntoConstraints = false
        memoryView.translatesAutoresizingMaskIntoConstraints = false
        netSpeedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cpuView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            cpuView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5,  constant: -navOffset * 0.5),
            cpuView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cpuView.topAnchor.constraint(equalTo: view.topAnchor, constant: navOffset),
            memoryView.leftAnchor.constraint(equalTo: cpuView.rightAnchor),
            memoryView.rightAnchor.constraint(equalTo: view.rightAnchor),
            memoryView.topAnchor.constraint(equalTo: cpuView.topAnchor),
            memoryView.heightAnchor.constraint(equalTo: cpuView.heightAnchor),
            netSpeedView.widthAnchor.constraint(equalTo: cpuView.widthAnchor),
            netSpeedView.leftAnchor.constraint(equalTo: cpuView.leftAnchor),
            netSpeedView.heightAnchor.constraint(equalTo: cpuView.heightAnchor),
            netSpeedView.topAnchor.constraint(equalTo: cpuView.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        memoryView.all = PerformMonitor.shared.allMemory
        memoryView.switchToMB()
        PerformMonitor.shared.startMonitor { cpu, memory, downloadRate, uploadRate in
            self.cpuView.used = cpu
            self.memoryView.used = memory
            self.netSpeedView.updateFlow(download: downloadRate, upload: uploadRate)
        }
    }
    
    deinit {
        PerformMonitor.shared.stopMonitor()
    }
}
