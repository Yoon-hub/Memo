//
//  SearchViewController.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/02.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseable)
        
    }
    
    override func configue() {
        super.configue()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


