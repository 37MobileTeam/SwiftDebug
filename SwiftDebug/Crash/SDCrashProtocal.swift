//
//  SDCrashProtocal.swift
//  SwiftDebug
//
//  Created by linzixin on 2021/12/26.
//

import Foundation
protocol SDCrashProtocal {
    var handle: (SDCrashModel) -> Void { get set }
}
