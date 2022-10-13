//
//  UserDefaults+Extension.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/04.
//

import Foundation

extension UserDefaults {
    
    static var firstVisited: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "first")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "first")
        }
    }
}
