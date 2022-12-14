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
    var tasks: Results<UserMemo>!
    
    //serachController 활성화 여부를 확인하는 코드
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive || isSearchBarHasText
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.keyboardDismissMode = .onDrag
        tasks = repository.fetch()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = NumberFormatter.plusComma(count: repository.fetch().count) + "개의 메모"
        mainView.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.firstVisited {
            let vc = WalkthroughViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
            UserDefaults.firstVisited = true
        }
        
    }
    
    override func configue() {
        super.configue()
        setNavigationConfigue()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseable)
        
        mainView.memoButton.addTarget(self, action: #selector(memoButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func memoButtonClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setNavigationConfigue() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey:"cancelButtonText")
        searchController.searchBar.tintColor = .tintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        
    }
}
//MARK: - Table
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = IfManager.shared.didSelectRowAt(isFiltering: isFiltering, tasks: tasks, indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        } else {
            return repository.fetchFixedMemo(bool: true).count > 0 ? 2 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return tasks.count
        } else {
            return IfManager.shared.numberOfRowsInSection(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseable, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell() }
        
        let data = IfManager.shared.cellForRowAt(indexPath: indexPath, isFiltering: isFiltering, tasks: tasks)
        
        if isFiltering {
            cell.titleLabel.attributedText = IfManager.shared.chageTextColor(text: data[TableViewCellData.title.rawValue], searchText: (navigationItem.searchController?.searchBar.text!)!)
            cell.contentLabel.attributedText = IfManager.shared.chageTextColor(text: data[TableViewCellData.content.rawValue] ?? "추가 택스트 없음", searchText: (navigationItem.searchController?.searchBar.text)!)
        } else {
            cell.titleLabel.text = data[TableViewCellData.title.rawValue]
            cell.titleLabel.textColor = .label
            cell.contentLabel.textColor = .systemGray   
            cell.contentLabel.text = data[TableViewCellData.content.rawValue]
        }
           
        cell.datelabel.text = data[TableViewCellData.dateStr.rawValue]
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return "\(tasks.count)개 찾음"
        } else {
            return IfManager.shared.titleForHeaderInSection(section: section)
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            if self.isFiltering {
                self.repository.deletItem(task: self.tasks[indexPath.row])
            } else {
                IfManager.shared.deleteButtoncClicked(indexPath: indexPath)
            }
            self.mainView.tableView.reloadData()
        }
        deleteButton.image = UIImage(systemName: "trash.fill")
        deleteButton.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fixButton = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            IfManager.shared.checkFixMemoCount(isFiltering: self.isFiltering, tasks: self.tasks, indexPath: indexPath) {
                self.showAlert(title: "메모는 5개 이상 못해요ㅠㅠㅠㅠㅠㅠ")
            }
            self.mainView.tableView.reloadData()
        }
        
        if isFiltering {
            fixButton.image = self.tasks[indexPath.row].fixed ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
        } else {
            if repository.fetchFixedMemo(bool: true).count > 0 {
                fixButton.image = indexPath.section == 0 ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
            } else {
                fixButton.image = UIImage(systemName: "pin.fill")
            }
        }
        
        fixButton.backgroundColor = .tintColor
        return UISwipeActionsConfiguration(actions: [fixButton])
    }
    
    //headerView font 변경
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .boldSystemFont(ofSize: 21)
        header.textLabel?.textColor = UIColor.label
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

//MARK: - SearchController
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        tasks = repository.filter(text: searchController.searchBar.text!)
        mainView.tableView.reloadData()
    }
    
    
}
