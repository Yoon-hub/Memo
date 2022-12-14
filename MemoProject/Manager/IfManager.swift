//
//  IfManager.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import UIKit
import RealmSwift

class IfManager {
    
    private init() {}
    
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
    
    func cellForRowAt(indexPath: IndexPath, isFiltering: Bool, tasks: Results<UserMemo>) -> [String]{
        
        let fixedTasks = repository.fetchFixedMemo(bool: true)
        let anfixedTasks = repository.fetchFixedMemo(bool: false)
        
        if isFiltering {
            return findTitle(tasks: tasks, indexPath: indexPath)
        } else {
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
    
    }

    private func findTitle(tasks: Results<UserMemo>, indexPath: IndexPath) -> [String] {
   
        let title = tasks[indexPath.row].title
        let content = tasks[indexPath.row].content ?? "추가 텍스트 없음"
        
        let interval = Date().timeIntervalSince(tasks[indexPath.row].date)
        
        let dateStr = DateFormatter.dateToString(date: tasks[indexPath.row].date, dateFormat:  timeInterval(interval: interval))
        
        return [title, content, dateStr]
    }
    
    
     func timeInterval(interval: TimeInterval) -> String {
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
    
    
    func fixedButtonClicked(indexPath: IndexPath) {
        let fixedTasks = self.repository.fetchFixedMemo(bool: true)
        let anfixedTasks = self.repository.fetchFixedMemo(bool: false)
        
        if fixedTasks.count > 0 {
            if indexPath.section == 0 {
                self.repository.fixedChage(task: fixedTasks[indexPath.row])
            }
            else {
                self.repository.fixedChage(task: anfixedTasks[indexPath.row])
            }
        } else {
            self.repository.fixedChage(task: anfixedTasks[indexPath.row])
        }
    }
    
    func checkFixMemoCount(isFiltering: Bool, tasks: Results<UserMemo>,indexPath: IndexPath, completion: @escaping () -> ()) {
        if isFiltering {
            if self.repository.fetchFixedMemo(bool: true).count >= 5 && tasks[indexPath.row].fixed == false {
                completion() // 메모 띄우기
            } else {
                self.repository.fixedChage(task: tasks[indexPath.row])
            }
        } else {
            if self.repository.fetchFixedMemo(bool: true).count >= 5 && indexPath.section == 1 {
                completion()
            } else {
                IfManager.shared.fixedButtonClicked(indexPath: indexPath)
            }
        }
    }
    
    func chageTextColor(text: String, searchText: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.tintColor, range: (text as NSString).range(of: searchText))
        return attributeString
    }
    
    func splitText(text: String) -> UserMemo{
        let split = text.split(separator: "\n")
        let title = split[0]
        var content: String? = nil
        
        if split.count > 1 {
            content = ""
            split[1...split.count-1].forEach { content! += "\($0) " }
        }
        
        let task = UserMemo(title: String(title), content: content)
        return task
    }
    
    func didSelectRowAt(isFiltering: Bool, tasks: Results<UserMemo>, indexPath: IndexPath) -> AddViewController{
        let vc = AddViewController()
        vc.modify = true
        if isFiltering {
            vc.backButtonTitle = "검색"
            vc.task = tasks[indexPath.row]
        } else {
            let fixedTasks = self.repository.fetchFixedMemo(bool: true)
            let anfixedTasks = self.repository.fetchFixedMemo(bool: false)
            if fixedTasks.count > 0 {
                if indexPath.section == 0 {
                    vc.task = fixedTasks[indexPath.row]
                } else {
                    vc.task = anfixedTasks[indexPath.row]
                }
            } else {
                vc.task = anfixedTasks[indexPath.row]
            }
        }
        return vc
    }
    
   
}
