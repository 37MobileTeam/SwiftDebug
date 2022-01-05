//
//  SDCrashHandler.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/25.
//

import Foundation
import MetricKit

class SDCrashHandler {
    private static var systemHandler: (@convention(c) (NSException) -> Void)? = nil
    private static var delegates: [SDCrashProtocal] = []
    private static var source: DispatchSourceSignal!
    static func startCatch() {
        if SDConfigCenter.shared.crashConfig.enable {
            print("已经开启了！～")
            return
        }
        
        // 捕获OC异常
        source = DispatchSource.makeSignalSource(signal: SIGTRAP, queue: .main)
        systemHandler = NSGetUncaughtExceptionHandler()
        NSSetUncaughtExceptionHandler(SDCrashHandler.exceptionHandler)
        // 捕获signal
        catchSignal()
        SDConfigCenter.shared.crashConfig.enable = true
    }
    
    static func stopCatch() {
        NSSetUncaughtExceptionHandler(systemHandler)
        signal(SIGABRT, SIG_DFL)
        signal(SIGILL, SIG_DFL)
        signal(SIGSEGV, SIG_DFL)
        signal(SIGFPE, SIG_DFL)
        signal(SIGBUS, SIG_DFL)
        signal(SIGPIPE, SIG_DFL)
    }
    
    private static func catchSignal() {
        source.setEventHandler {
            var stack = Thread.callStackSymbols
            stack.removeFirst(2)
            let callStack = stack.joined(separator: "\r")
            print("signal:\(stack)")
        }
        signal(SIGABRT, signalHandler)  // abort信号
        signal(SIGILL, signalHandler)   // 非法指令
        signal(SIGSEGV, signalHandler)  // 段异常
        signal(SIGFPE, signalHandler)
        signal(SIGBUS, signalHandler)   // 总线错误
        signal(SIGPIPE, signalHandler)
        signal(SIGTRAP, signalHandler)
        signal(SIGKILL, signalHandler)
        signal(SIGSYS, signalHandler)
        signal(SIGINT, signalHandler)
        signal(SIGXFSZ, signalHandler)  // 文件大小超出限制
    }
    
    private static let exceptionHandler: @convention(c) (NSException) -> Void = { exception in
        systemHandler?(exception)
        let name = exception.name
        let reason = exception.reason ?? ""
        let userInfo = exception.userInfo ?? [:]
        let callStackSymbols = exception.callStackSymbols
        let callStackReturnAddresses = exception.callStackReturnAddresses
        let exceptionModel = SDCrashModel(type: .exception, name: name.rawValue, reason: reason, userInfo: userInfo, callStack: "")
        for delegate in SDCrashHandler.delegates {
            delegate.handle(exceptionModel)
        }
    }
    
    private static let signalHandler : @convention(c) (Int32) -> Void = { (signal) -> Void in
        var stack = Thread.callStackSymbols
        stack.removeFirst(2)
        let callStack = stack.joined(separator: "\r")
        print("signal:\(signal)")
    }
}

