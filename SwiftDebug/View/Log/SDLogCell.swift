//
//  SDLogCell.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/9.
//

import Foundation
import UIKit
class SDLogCell: UITableViewCell {
    var generalConfig: SDGeneralConfig {
        SDConfigCenter.shared.genernalConfig
    }
    var logConfig: SDLogConfig {
        SDConfigCenter.shared.logConfig
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if contentLabel.frame.contains(point) {
            return contentLabel
        }
        return super.hitTest(point, with: event)
    }
    
    lazy var orderLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.textColor = generalConfig.mainTextColor
        view.font = logConfig.logCellFont
        view.text = "序号"
        return view
    }()
    
    lazy var levelLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = generalConfig.mainTextColor
        view.isUserInteractionEnabled = true
        view.font = logConfig.logCellFont
        view.text = "级别"
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = generalConfig.mainTextColor
        view.isUserInteractionEnabled = true
        view.font = logConfig.logCellFont
        view.text = "时间"
        return view
    }()
    
    lazy var typeLebel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = generalConfig.mainTextColor
        view.isUserInteractionEnabled = true
        view.font = logConfig.logCellFont
        view.text = "类型"
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = generalConfig.mainTextColor
        view.isUserInteractionEnabled = true
        view.font = logConfig.logCellFont
        view.numberOfLines = 0
        view.text = "标题"
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.textColor = generalConfig.mainTextColor
        view.font = logConfig.logCellFont
        view.text = "内容"
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(orderLabel)
        addSubview(levelLabel)
        addSubview(timeLabel)
        addSubview(typeLebel)
        addSubview(titleLabel)
        addSubview(contentLabel)
        contentLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(copyPaste)))
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        let constant = logConfig
        NSLayoutConstraint.activate([
            orderLabel.leftAnchor.constraint(equalTo: leftAnchor),
            orderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            orderLabel.widthAnchor.constraint(equalToConstant: constant.logOrderWidth),
            orderLabel.heightAnchor.constraint(equalTo: heightAnchor),
            
            levelLabel.leftAnchor.constraint(equalTo: orderLabel.rightAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            levelLabel.widthAnchor.constraint(equalToConstant: constant.logLevelWidth),
            levelLabel.heightAnchor.constraint(equalTo: heightAnchor),
            
            timeLabel.leftAnchor.constraint(equalTo: levelLabel.rightAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: constant.logTimeWidth),
            timeLabel.heightAnchor.constraint(equalTo: heightAnchor),
            
            typeLebel.leftAnchor.constraint(equalTo: timeLabel.rightAnchor),
            typeLebel.centerYAnchor.constraint(equalTo: centerYAnchor),
            typeLebel.widthAnchor.constraint(equalToConstant: constant.logTypeWidth),
            typeLebel.heightAnchor.constraint(equalTo: heightAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: typeLebel.rightAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: constant.logTitleWidth),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            
            contentLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
        if (constant.logOrderWidth + constant.logLevelWidth + constant.logTimeWidth + constant.logTitleWidth + constant.logContentWidth) < mainBounds().width {
            contentLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        } else {
            contentLabel.widthAnchor.constraint(equalToConstant: constant.logContentWidth - 5).isActive = true
        }
    }
    
    func setFont(font: UIFont) {
        orderLabel.font = font
        levelLabel.font = font
        timeLabel.font = font
        typeLebel.font = font
        titleLabel.font = font
        contentLabel.font = font
    }
    
    func update(order: String, logModel: SDLogModel) {
        orderLabel.text = order
        levelLabel.text = logModel.level.description
        timeLabel.text = logModel.time
        typeLebel.text = logModel.type.description
        titleLabel.text = logModel.title
        contentLabel.text = logModel.content
        let textColor: UIColor
        let config = SDConfigCenter.shared.logConfig
        switch logModel.level {
        case .info:
            textColor = config.logInfoTextColor
        case .warn:
            textColor = config.logWarnTextColor
        case .error:
            textColor = config.logErrorTextColor
        }
        orderLabel.textColor = textColor
        levelLabel.textColor = textColor
        timeLabel.textColor = textColor
        typeLebel.textColor = textColor
        titleLabel.textColor = textColor
        contentLabel.textColor = textColor
    }
    
    @objc func copyPaste() {
        let pastboard = UIPasteboard.general
        pastboard.string = contentLabel.text
    }
}
