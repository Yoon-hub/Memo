//
//  UserMemoRepository.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import RealmSwift

protocol UserMemoRepositroyType {
    func fetchFixedMemo(bool: Bool) -> Results<UserMemo>
}

class UserMemoRepositroy: UserMemoRepositroyType {
    
    let localRealm = try! Realm()
    
    func fetchFixedMemo(bool: Bool) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter(("fixed == \(bool)"))
    }
    
    
}
