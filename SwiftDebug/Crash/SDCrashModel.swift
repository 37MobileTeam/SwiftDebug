//
//  SDCrashModel.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/26.
//

import Foundation
struct SDCrashModel {
    var type: SDCrashType
    var name: String
    var reason: String
    var userInfo: [AnyHashable: Any]
    var callStack: String
}

enum SDCrashType {
    case signal
    case exception
}
