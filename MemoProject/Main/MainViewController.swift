//
//  MainViewController.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/08/31.
//

import UIKit
import RealmSwift

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    let repository = UserMemoRepositroy()
    //var tasks: Results<UserMemo>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func configue() {
        super.configue()
        setNavigationConfigue()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseable)
    }
    
    func setNavigationConfigue() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey:"cancelButtonText")
        searchController.searchBar.tintColor = .tintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let count = NSNumber(value: Int32(repository.fetch().count))
        navigationItem.title = NumberFormatter.plusComma(count: count) + "개의 메모"
        navigationItem.searchController = searchController
        
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repository.fetchFixedMemo(bool: true).count > 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IfManager.shared.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseable, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell() }
        
        let data = IfManager.shared.cellForRowAt(indexPath: indexPath)
        
        cell.titleLabel.text = data[TableViewCellData.title.rawValue]
        cell.datelabel.text = data[TableViewCellData.dateStr.rawValue]
        cell.contentLabel.text = data[TableViewCellData.content.rawValue]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return IfManager.shared.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            IfManager.shared.deleteButtoncClicked(indexPath: indexPath)
            self.mainView.tableView.reloadData()
        }
        deleteButton.image = UIImage(systemName: "trash.fill")
        deleteButton.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fixButton = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            
        }
        
        return UISwipeActionsConfiguration(actions: [])
    }
    
    
    //headerView font 변경
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .boldSystemFont(ofSize: 21)
        header.textLabel?.textColor = UIColor.label
    }
    
    
    
    
    
}


