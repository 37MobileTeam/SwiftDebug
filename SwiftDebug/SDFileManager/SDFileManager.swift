//
//  FileManager.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/29.
//

import Foundation
class SDFileManager {
    static var shared: SDFileManager = SDFileManager()
    var manager: FileManager = FileManager.default
    
    /// 创建文件，存在会抛异常
    func getFile(_ path: String, data: Data?) throws -> SDFile {
        guard !fileExists(path) else {
            throw SDFileError.fileExist
        }
        _ = createFile(path, data: data)
        var file = SDFile(filepath: path)
        file.data = data ?? Data()
        return file
    }
    
    /// 获取文件，不存在则创建
    func getFile(_ path: String) throws -> SDFile {
        do {
            return try getFile(path, data: nil)
        } catch {
            if let reust = searchFile(path) {
                return reust
            }
        }
        throw SDFileError.fileGetError
    }
    
    /// 查找文件，不存在返回nil
    func searchFile(_ path: String) -> SDFile? {
        var file: SDFile? = nil
        if fileExists(path) {
            file = SDFile(filepath: path)
            guard let data = manager.contents(atPath: path) else { return file }
            file!.data = data
        }
        return file
    }
    
    /// 判断文件是否存在
    func fileExists(_ path: String) -> Bool {
        manager.fileExists(atPath: path)
    }
    
    /// 通过path创建文件
    func createFile(_ path: String, data: Data?) -> Bool {
        manager.createFile(atPath: path, contents: data, attributes: nil)
    }
    
    /// 删除文件
    func deleteFile(path: String) -> Bool {
        do {
            try manager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    /// 文件是否可读
    func isReadable(_ filepath: String) -> Bool {
        manager.isReadableFile(atPath: filepath)
    }
    
    ///  文件是否可写
    func isWriteable(_ filepath: String) -> Bool {
        manager.isWritableFile(atPath: filepath)
    }
    
}
