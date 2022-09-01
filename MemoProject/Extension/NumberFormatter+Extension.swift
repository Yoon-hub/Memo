//
//  NumberFormatter+Extension.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

extension NumberFormatter {
    
    static func plusComma(count: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
    
        return formatter.string(from: count) ?? "0" 
        
    }
}
