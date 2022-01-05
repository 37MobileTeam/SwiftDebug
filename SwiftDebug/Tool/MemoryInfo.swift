//
//  SysInfo.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/8.
//

import Foundation

struct MemoryInfo {
    /// 获取物理内存（GB）
    var physicalMemory = Double(ProcessInfo.processInfo.physicalMemory).toGB
    /// 获取当前应用内存使用情况（MB）
    func getMemory() -> Double {
        var info = mach_task_basic_info()
        let MACH_TASK_BASIC_INFO_COUNT = MemoryLayout<mach_task_basic_info>.stride / MemoryLayout<natural_t>.stride
        var count = mach_msg_type_number_t(MACH_TASK_BASIC_INFO_COUNT)
        let _ = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: MACH_TASK_BASIC_INFO_COUNT) {
                
                    task_info(mach_task_self_,
                            task_flavor_t(MACH_TASK_BASIC_INFO),
                            $0,
                            &count)
            }
        }
        return Double(info.resident_size.toMB)
    }
    
    /// 获取系统内存信息（MB）
    func getSysMemory() -> (free: Double, active: Double, inactive: Double, compree: Double) {
        let statistics = VMStatistics64()
        let pageSize = Double(vm_kernel_page_size)
        let free = Double(statistics.free_count) * pageSize
        let active = Double(statistics.active_count) * pageSize
        let inactive = Double(statistics.inactive_count) * pageSize
        let compress = Double(statistics.compressor_page_count) * pageSize
        
        return (free.toMB, active.toMB, inactive.toMB, compress.toMB)
    }
    
    
    private func VMStatistics64() -> vm_statistics64 {
        let host_port: host_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(UInt32(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size))

        var returnData:vm_statistics64 = vm_statistics64()
        let _ = withUnsafeMutablePointer(to: &returnData) {
            (p:UnsafeMutablePointer<vm_statistics64>) -> Bool in
            return p.withMemoryRebound(to: integer_t.self, capacity: Int(host_size)) {
                (pp:UnsafeMutablePointer<integer_t>) -> Bool in

                let retvalue = host_statistics64(host_port, HOST_VM_INFO64,
                                              pp, &host_size)
                return retvalue == KERN_SUCCESS
            }
        }
        return returnData
    }
}

fileprivate extension Double {
    var toMB: Double {
        return self / 1048576
    }
    
    var toGB: Double {
        return self / 1073741824
    }
}

fileprivate extension UInt64 {
    var toMB: UInt64 {
        return self / 1048576
    }
}
