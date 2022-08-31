//
//  RealmModel.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import RealmSwift

class UserMemo: Object {
    @Persisted var title: String
    @Persisted var date: Date
    @Persisted var content: String?
    @Persisted var fixed: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(title: String, content: String?) {
        self.init()
        self.title = title
        self.date = Date()
        self.content = content
        self.fixed = false
    }
    
}
