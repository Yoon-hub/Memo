//
//  ReuseableProtocol.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/08/31.
//

import UIKit

protocol ReuseableProtocol {
    static var reuseable: String { get }
}

extension UITableViewCell: ReuseableProtocol {
    static var reuseable: String {
        return String(describing: self)
    }
    
    
}
