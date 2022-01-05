//
//  FuncListViewController.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/8.
//

import Foundation
import UIKit

/*
 首页功能列表
 */
class SDFunListViewController: SDViewController {
    let cellDefaultImg = UIImage(named: "cell-default", in: Bundle.SDK, compatibleWith: nil)
    var data: [SDFuncListModel] = [
        SDFuncListModel(icon: "log", title: "日志"),
        SDFuncListModel(icon: "setting", title: "设置"),
//        SDFuncListModel(icon: "net", title: "网络"),
        SDFuncListModel(icon: "vpn", title: "代理"),
        SDFuncListModel(icon: "setting1", title: "性能监控"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
//        SDFuncListModel(icon: "log", title: "测试"),
    ]
    override var navTitle: String {
        return "功能列表"
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SDFuncListCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        layout.itemSize = .init(width: SDConfigCenter.shared.genernalConfig.funcListCellWidth, height: SDConfigCenter.shared.genernalConfig.funcListCellHeigth)
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: navOffset, width: mainBounds().width, height: 300)
    }
}

extension SDFunListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = SDLogViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = SDSettingVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = SDProxyVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            navigationController?.pushViewController(SDPerformVC(), animated: true)
        }
    }
}

extension SDFunListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SDFuncListCell
        let item = data[indexPath.row]
        if let img = UIImage(named: item.icon, in: Bundle.SDK, compatibleWith: nil) {
            cell.update(image: img, title: item.title)
            return cell
        }
        cell.update(image: cellDefaultImg, title: item.title)
        return cell
    }
}

extension SDFunListViewController {
    func testData() -> [SDLogModel]{
        // 测试数据
        var logs: [SDLogModel] = []
        var content: String = "内容"
        for i in 1...10 {
            var level: SDLogLevel
            var type: SDLogType
            content.append(content)
            if i % 3 == 0 {
                level = .info
            } else if i % 3 == 1 {
                level = .warn
            } else {
                level = .error
            }
            if i % 2 == 0 {
                type = .network
            } else {
                type = .print
            }
            logs.append(.init(id: String(i), level: level, type: type, title: "标题\(i)", content: content))
        }
        return logs
    }
}
