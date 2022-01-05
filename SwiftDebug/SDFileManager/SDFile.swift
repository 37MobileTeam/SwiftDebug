//
//  SDFile.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/29.
//

import Foundation
struct SDFile: SDFileProtocal {
    private var fileHandle: FileHandle!
    private var appendData: Data?
    var data: Data = Data()
    var filename: String {
        filepath.components(separatedBy: "/").last ?? ""
    }
    var filepath: String 
    var isWritable: Bool {
        SDFileManager.shared.isWriteable(filepath)
    }
    var isReadable: Bool {
        SDFileManager.shared.isReadable(filepath)
    }
    var isExists: Bool {
        SDFileManager.shared.fileExists(filepath)
    }
    
    func create(replace: Bool) -> Bool {
        SDFileManager.shared.createFile(filepath, data: data)
    }
    
    mutating func append(data: Data) {
        if appendData == nil {
            appendData = data
        } else {
            appendData!.append(data)
        }
    }
    
    mutating func appendFlush(data: Data) throws {
        append(data: data)
        try flush()
    }
    
    func delete() -> Bool {
        SDFileManager.shared.deleteFile(path: filepath)
    }
    
    mutating func flush() throws {
        if fileHandle == nil {
            try createHandle()
        }
        if !isExists {
            throw SDFileError.fileNotExist
        }
        if let newData = appendData {
            if #available(iOS 13.4, *) {
                try fileHandle.seekToEnd()
                try fileHandle.write(contentsOf: newData)
            } else {
                // Fallback on earlier versions
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
            }
            data.append(newData)
            appendData = nil
        }
    }
    
    init(filepath: String) {
        self.filepath = filepath
    }
    
    private mutating func createHandle() throws {
        switch (isWritable, isReadable) {
        case (true, true):
            fileHandle = FileHandle(forUpdatingAtPath: filepath)
        case (true, false):
            fileHandle = FileHandle(forWritingAtPath: filepath)
        case (false, true):
            fileHandle = FileHandle(forReadingAtPath: filepath)
        default:
            throw SDFileError.noPermission
        }
    }
}

extension SDFile {
    mutating func appendFlush(_ str: String, sperator: String = "\n") {
        var newStr = str
        if data.count != 0 || (appendData?.count != nil && appendData!.count > 0) {
            newStr.insert("\n", at: newStr.startIndex)
        }
        if let data = newStr.data(using: .utf8) {
            try? appendFlush(data: data)
        }
    }
}
