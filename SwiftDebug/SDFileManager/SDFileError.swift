//
//  FileError.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/29.
//

import Foundation
enum SDFileError: Error {
    case fileNotExist
    case fileExist
    case fileGetError
    case noPermissionToRead
    case noPermissionToWrite
    case noPermission
}
