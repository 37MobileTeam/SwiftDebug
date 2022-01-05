//
//  SDLogModel.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/9.
//

import Foundation
struct SDLogModel: Codable {
    var id: String
    var level: SDLogLevel = .info
    var time: String = Date().time
    var type: SDLogType = .undefined
    var title: String
    var content: String
    var jsonString: String {
        return "{time: \(time), levle: \(level.description), type: \(type.description), title: \(title), content: \(content)}"
    }
}

@objc public enum SDLogLevel: Int, CustomStringConvertible, Codable {
    case info = 0
    case warn = 1
    case error = 2
    public var description: String {
        switch self {
        case .info:
            return "info"
        case .warn:
            return "warn"
        case .error:
            return "error"
        }
    }
}

@objc public enum SDLogType: Int, CustomStringConvertible, Codable {
    case network
    case print
    case undefined
    public var description: String {
        switch self {
        case .network:
            return "网络"
        case .print:
            return "打印"
        case .undefined:
            return "未定义"
        }
    }
}
