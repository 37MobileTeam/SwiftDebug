//
//  SDDataCenter.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/11.
//

import Foundation

struct SDDataCenter {
    static var shared: SDDataCenter = SDDataCenter()
    var logs: [SDLogModel] = []
}
