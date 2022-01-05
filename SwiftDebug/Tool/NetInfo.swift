//
//  NetInfo.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/8.
//

import Foundation
import CoreTelephony

struct NetInfo {
    /// 获取网络流量信息，单位Byte
    /// totalReceived: 收到的流量
    /// totalSend: 发送的流量
    func requestNetFlow() -> (totalReceived: UInt32, totalSend: UInt32) {
        var ifaddress: UnsafeMutablePointer<ifaddrs>? = nil
        let ret = getifaddrs(&ifaddress)
        var totalIn: UInt32 = 0
        var totalOut: UInt32 = 0
        if ret < 0 {
            return (totalIn, totalOut)
        }
        var ptr = ifaddress?.pointee.ifa_next
        while ptr != nil, let ifa = ifaddress?.pointee {
            let flag = Int32(ifa.ifa_flags)
            guard flag&IFF_UP != 0, flag & IFF_RUNNING != 0 else { continue }
            let data = ifa.ifa_data.bindMemory(to: if_data.self, capacity: 1).pointee
//            let name = ifa.ifa_name
            totalIn = totalIn + data.ifi_ibytes
            totalOut = totalOut + data.ifi_obytes
            if ifa.ifa_next == ptr {
                break
            }
            ptr = ifa.ifa_next
        }
        freeifaddrs(ifaddress)
        return (totalIn, totalOut)
    }
}
