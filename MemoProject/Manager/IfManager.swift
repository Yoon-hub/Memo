//
//  IfManager.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import RealmSwift

class IfManager {
    
    static let shared = IfManager()
    
    let repository = UserMemoRepositroy()
    
    func numberOfRowsInSection(section: Int) -> Int {
    
        if repository.fetchFixedMemo(bool: true).count > 0 {
            if section == 0 {
                return repository.fetchFixedMemo(bool: true).count
            } else {
                return repository.fetchFixedMemo(bool: false).count
            }
        } else {
            return repository.fetchFixedMemo(bool: false).count
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        if repository.fetchFixedMemo(bool: true).count > 0 {
            if section == 0 {
                return "고정된 메모"
            } else {
                return "메모"
            }
        } else {
            return "메모"
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> [String]{
        
        let fixedTasks = repository.fetchFixedMemo(bool: true)
        let anfixedTasks = repository.fetchFixedMemo(bool: false)
        
        if fixedTasks.count > 0 {
            if indexPath.section == 0 {
               return findTitle(tasks: fixedTasks, indexPath: indexPath)
            } else {
                return findTitle(tasks: anfixedTasks, indexPath: indexPath)
            }
        } else {
            return findTitle(tasks: anfixedTasks, indexPath: indexPath)
        }
    }

    private func findTitle(tasks: Results<UserMemo>, indexPath: IndexPath) -> [String] {
   
        let title = tasks[indexPath.row].title
        let content = tasks[indexPath.row].content ?? "추가 텍스트 없음"
        
        let interval = Date().timeIntervalSince(tasks[indexPath.row].date)
        
        let dateStr = DateFormatter.dateToString(date: tasks[indexPath.row].date, dateFormat:  timeInterval(interval: interval))
        
        return [title, content, dateStr]
    }
    
    
    private func timeInterval(interval: TimeInterval) -> String {
        var dateFormat: String
        if interval < 86000 {
            dateFormat = "a hh:mm"
        } else if interval < 86000 * 7 {
            dateFormat = "EEEE"
        } else {
            dateFormat = "yyyy.MM.dd a hh:mm"
        }
        return dateFormat
    }
    
    func deleteButtoncClicked(indexPath: IndexPath) {
        
        let fixedTasks = self.repository.fetchFixedMemo(bool: true)
        let anfixedTasks = self.repository.fetchFixedMemo(bool: false)
        
        if fixedTasks.count > 0 {
            if indexPath.section == 0 {
                self.repository.deletItem(task: fixedTasks[indexPath.row])
            } else {
                self.repository.deletItem(task: anfixedTasks[indexPath.row])
            }
            
        } else {
            self.repository.deletItem(task: anfixedTasks[indexPath.row])
        }
       
    }
   
}
