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
    func fixedChage(task: UserMemo)
    func filter(text: String) -> Results<UserMemo>
    func addItem(task: UserMemo)
    func modifyItem(chagneTask: UserMemo, task: UserMemo)
}

class UserMemoRepositroy: UserMemoRepositroyType {
    
    let localRealm = try! Realm()
    
    
    func fetch() -> Results<UserMemo> {
        //print("Realm is located at:", localRealm.configuration.fileURL!)
        return localRealm.objects(UserMemo.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFixedMemo(bool: Bool) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).sorted(byKeyPath: "date", ascending: false).filter(("fixed == \(bool)"))
    }
    
    func deletItem(task: UserMemo) {
        try! localRealm.write {
            localRealm.delete(task)
        }
    }
    
    func fixedChage(task: UserMemo) {
        try! localRealm.write {
            task.fixed = !task.fixed
        }
    }
    
    func filter(text: String) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter("title CONTAINS '\(text)' or content CONTAINS '\(text)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func addItem(task: UserMemo) {
        
        try! localRealm.write {
            localRealm.add(task) //Create
        }
    }
    
    func modifyItem(chagneTask: UserMemo, task: UserMemo) {
        try! localRealm.write {
            chagneTask.content = task.content
            chagneTask.title = task.title
            chagneTask.date = Date()
        }
    }
    
}
