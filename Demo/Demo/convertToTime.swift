//
//  convertToTime.swift
//  Demo
//
//  Created by GoEun Jeong on 2022/03/07.
//

import Foundation

extension Double {
    public func convertToTime() -> String {
        let time = self
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02ld:%02ld", minute, second)
    }
}
