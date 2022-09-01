//
//  UserMemoRepository.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import RealmSwift

protocol UserMemoRepositroyType {
    func fetch() -> Results<UserMemo>
    func fetchFixedMemo(bool: Bool) -> Results<UserMemo>
    func deletItem(task: UserMemo)
}

class UserMemoRepositroy: UserMemoRepositroyType {
    
    let localRealm = try! Realm()
    
    
    func fetch() -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self)
    }
    
    func fetchFixedMemo(bool: Bool) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).sorted(byKeyPath: "date", ascending: true).filter(("fixed == \(bool)"))
    }
    
    func deletItem(task: UserMemo) {
        try! localRealm.write {
            localRealm.delete(task)
        }
    }
    
}
