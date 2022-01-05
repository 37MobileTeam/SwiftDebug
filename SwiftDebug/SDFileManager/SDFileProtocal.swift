//
//  SDFileProtocal.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/29.
//

import Foundation
protocol SDFileProtocal {
    var filename: String { get }
    var filepath: String { get }
    var isWritable: Bool { get }
    var isReadable: Bool { get }
    var isExists: Bool { get }
    // 创建文件
    func create(replace: Bool) -> Bool
    // 追加数据
    mutating func append(data: Data)
    // 删除文件
    func delete() -> Bool
    // 将数据刷新到文件中
    mutating func flush() throws
}
