//
//  SDAutoCompleleView.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/16.
//

import Foundation
import UIKit

class SDACTFCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label: UILabel = UILabel.init()
        label.textColor = SDConfigCenter.shared.genernalConfig.mainTextColor
        label.font = .systemFont(ofSize: 14.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(self.label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showWithString(string: String) {
        label.text = string
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28.0).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: 16.0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
    }
}
class SDAutoCompleteTextField: UITextField {
    
    private var heightCons: NSLayoutConstraint!
    public var showAutoComplete: Bool = true
    
    public var spView: UIView? = UIView() {
        didSet {
            spView?.addSubview(tableView)
        }
    }
    
    public var autoCompleteStrings = ["10.23.2.122",
                                       "10.14.8.32",
                                       "10.16.19.245"]
    
    
    public var onSelect:(String, IndexPath)->() = {_,_ in}
    public var onChange:(String)->() = {_ in}
    
    private var matchedSuffixArray = [String]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isUserInteractionEnabled = true
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SDACTFCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = UIView()
        return tableView
    }()
    
    private var tableViewHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        addTarget(self, action: #selector(textFieldDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEnd), for: .editingDidEnd)
        font = .systemFont(ofSize: 14.0)
        clearButtonMode = .whileEditing
        autocapitalizationType = .none
        autocorrectionType = .no
        if let clearButton = value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(clearButton.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .lightGray
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
// MARK: constraint
    override func layoutSubviews() {
        super.layoutSubviews()
        if heightCons == nil {
            let point = getConvertedPoint(self, baseView: spView!)
            heightCons = tableView.heightAnchor.constraint(equalToConstant: 1)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: spView!.topAnchor, constant: point.y + self.bounds.height + 1),
                tableView.leftAnchor.constraint(equalTo: spView!.leftAnchor, constant: point.x),
                tableView.widthAnchor.constraint(equalToConstant: frame.width),
                heightCons
            ])
            tableView.separatorStyle = .none
            tableView.separatorColor = .clear
        }
    }
    
    func getConvertedPoint(_ targetView: UIControl, baseView: UIView) -> CGPoint {
        var pnt = targetView.frame.origin
        if nil == targetView.superview {
            return pnt
        }
        var superView = targetView.superview
        while superView != baseView {
            pnt = superView!.convert(pnt, to: superView!.superview)
            if nil == superView!.superview {
                break
            } else {
                superView = superView!.superview
            }
        }
        return superView!.convert(pnt, to: baseView)
    }
    
    private func updateTable(_ text: String) {
        if !showAutoComplete {
            tableView.isHidden = true
            return
        }
        tableView.isHidden = text.isEmpty
        matchedSuffixArray = autoCompleteStrings
        if text.isEmpty {
            matchedSuffixArray = autoCompleteStrings
        } else {
            matchedSuffixArray = autoCompleteStrings.filter({ (str) -> Bool in
                return str.starts(with: text)
            })
        }
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            tableView.isHidden = text.isEmpty
            updateTableViewConstraints()
        }
    }
    
    @objc func textFieldDidBegin() {
        guard let text = text else {
            return
        }
        updateTable(text)
    }
    
    @objc func textFieldDidChange() {
        guard let text = text else {
            return
        }
        onChange(text)
        updateTable(text)
    }
    
    @objc func textFieldDidEnd() {
        guard let _ = text else {
            return
        }
        tableView.isHidden = true
    }
    
    private func updateTableViewConstraints() {
        
        var height: CGFloat = CGFloat(matchedSuffixArray.count) * 32.0
        if matchedSuffixArray.count > 3 {
            height = 4.0 * 32.0
        }
        if matchedSuffixArray.count == 0 {
            height = 1.0
        }
        heightCons.constant = height
    }
}

// MARK: @protocol - UITableViewDelegate
extension SDAutoCompleteTextField: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        text = matchedSuffixArray[indexPath.row]
        onSelect(text!, indexPath)
        tableView.isHidden = true
    }
}

// MARK: @protocol - UITableViewDataSource
extension SDAutoCompleteTextField: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedSuffixArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SDACTFCell
        cell.showWithString(string: matchedSuffixArray[indexPath.row])
        return cell
    }
}
