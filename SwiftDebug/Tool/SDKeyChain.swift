//
//  SDKeyChain.swift
//  SwiftDebug
//
//  Created by 林子鑫 on 2021/11/16.
//

import Foundation
class SDKeyChain {
    /// 存储
    static func set(key: String, value: String) {
        let keychain = KeychainSwift()
        keychain.set(value, forKey: key)
    }
    
    static func set(key: String, value: Bool) {
        let keychain = KeychainSwift()
        keychain.set(value, forKey: key)
    }
    
    static func set(key: String, value: [String]) {
        let keychain = KeychainSwift()
        if let data = try? JSONEncoder().encode(value) {
            keychain.set(data, forKey: key)
        } else {
            SwiftDebug.log(level: .error, type: .print, title: "KeyChain", content: "SDKeyChain存储数组时，转换成data失败")
        }
    }
    
    /// 取值
    static func queryString(key: String) -> String {
        let keychain = KeychainSwift()
        return keychain.get(key) ?? ""
    }
    
    static func queryBool(key: String) -> Bool {
        let keychain = KeychainSwift()
        return keychain.getBool(key) ?? false
    }
    
    static func queryArray(key: String) -> [String] {
        let keychain = KeychainSwift()
        if let data = keychain.getData(key), let rt = try? JSONDecoder().decode([String].self, from: data) {
            return rt
        }
        return []
    }
}
