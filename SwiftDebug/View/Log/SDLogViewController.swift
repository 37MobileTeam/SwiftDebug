//
//  SDLogViewController.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/9.
//

import Foundation
import UIKit

// 日志界面
class SDLogViewController: SDViewController {
    var tableView: UITableView = {
        let view = UITableView()
        view.register(SDLogCell.self, forCellReuseIdentifier: "cell")
        view.separatorInset = .zero
        view.contentInset = .zero
        // iOS15 顶部向下偏移的问题
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        
        return view
    }()
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    lazy var optScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var searchBar: SDSearchBar = {
        let view = SDSearchBar()
        view.placeholder = "设置过滤条件"
        return view
    }()
    
    lazy var clearBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("清空", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 6
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.backgroundColor = UIColor(rgba: "FF3030")
        view.setImage(UIImage(named: "clear", in: Bundle.SDK, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()
    
    var logs: [SDLogModel] = SDDataCenter.shared.logs
    
    override var navTitle: String {
        return "日志"
    }
    
    @objc func stopEdit() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        view.addSubview(scrollView)
        view.addSubview(optScrollView)
        view.sendSubviewToBack(optScrollView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEdit)))
        optScrollView.addSubview(searchBar)
        optScrollView.addSubview(clearBtn)
        scrollView.addSubview(tableView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        optScrollView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let config = SDConfigCenter.shared.logConfig
        NSLayoutConstraint.activate([
            optScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: navOffset),
            optScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            optScrollView.heightAnchor.constraint(equalToConstant: config.logOptHeight),
            optScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: optScrollView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        var tableWidth = config.logOrderWidth + config.logTitleWidth + config.logLevelWidth + config.logTypeWidth + config.logContentWidth + config.logTimeWidth
        if tableWidth < view.frame.width {
            tableWidth = view.frame.width
        }
        tableView.frame = .init(origin: .zero, size: .init(width: tableWidth, height: view.frame.height - navOffset - config.logOptHeight))
        scrollView.contentSize.width = tableWidth
        searchBar.frame = .init(x: 100, y: 5, width: view.frame.width - 112, height: config.logOptHeight - 10)
        clearBtn.frame = .init(x: 12, y: 5, width: 80, height: config.logOptHeight - 10)
        clearBtn.addTarget(self, action: #selector(clearLog), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(addLog(notify:)), name: Notification.Name(SwiftDebug.addLogNotification), object: nil)
    }
    
    @objc func clearLog() {
        logs = []
        SDDataCenter.shared.logs = []
        tableView.reloadData()
    }
    
    @objc private func addLog(notify: Notification) {
        if let log = notify.object as? SDLogModel {
            var needScroll = false
            DispatchQueue.main.async {[unowned self] in
                if let indexpath = tableView.indexPathsForVisibleRows {
                    needScroll = indexpath.compactMap({ $0.row }).contains(logs.count - 1)
                }
                logs.append(log)
                tableView.reloadData()
                if needScroll {
                    tableView.scrollToRow(at: .init(row: logs.count - 1, section: 0), at: .bottom, animated: true)
                }
            }
        }
    }
}

extension SDLogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension SDLogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        SDConfigCenter.shared.logConfig.logHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SDLogCell()
        view.setFont(font: SDConfigCenter.shared.logConfig.logHeaderFont)
        view.backgroundColor = SDConfigCenter.shared.logConfig.logHeaderBgColor
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SDLogCell
        cell.update(order: String(indexPath.row), logModel: logs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = logs[indexPath.row]
        return data.content.textHeight(font: SDConfigCenter.shared.logConfig.logCellFont, width: SDConfigCenter.shared.logConfig.logContentWidth) + 10
    }
    
}

extension SDLogViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            logs = SDDataCenter.shared.logs
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text?.lowercased(), searchText != "" {
            logs = SDDataCenter.shared.logs.filter { log in
                log.content.lowercased().contains(searchText) ||
                log.title.lowercased().contains(searchText) ||
                log.type.description.lowercased().contains(searchText) ||
                log.level.description.lowercased().contains(searchText)
            }
            tableView.reloadData()
        }
    }
}
