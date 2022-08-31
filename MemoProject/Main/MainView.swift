//
//  MainView.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/08/31.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 65
        view.backgroundColor = .bgColor
        return view
    }()
    
    var memoButton: UIButton = {
        let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50)
        view.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: config), for: .normal)
        view.tintColor = .tintColor
        return view
    }()
    
    override func configure() {
        super.configure()
        [tableView, memoButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
        memoButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-16)
            make.bottom.equalTo(tableView.snp.bottom).offset(16)
            make.width.height.equalTo(30)
        }
    }
}

