//
//  NumberFormatter+Extension.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

extension NumberFormatter {
    
    static func plusComma(count: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
    
        return formatter.string(for: count) ?? "0"
    }
}
