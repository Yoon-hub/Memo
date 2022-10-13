//
//  DateFormatter.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

extension DateFormatter {
    
    static func dateToString(date: Date, dateFormat: String) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(abbreviation: "KST")
        format.dateFormat = dateFormat
        let result = format.string(from: date)
        return result
    }
    
}
