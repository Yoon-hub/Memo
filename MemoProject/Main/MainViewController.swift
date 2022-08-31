//
//  MainViewController.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/08/31.
//

import UIKit

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configue() {
        super.configue()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey:"cancelButtonText")
        searchController.searchBar.tintColor = .tintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "1,234개의 메모"
        navigationItem.searchController = searchController
        
    }
}

