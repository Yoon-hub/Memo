//
//  MainTableViewCell.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation
import UIKit

final class MainTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let datelabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    
    override func configure() {
        super.configure()
        
        [titleLabel, datelabel, contentLabel].forEach { self.addSubview($0) }

    }
    
    override func setConstraints() {
        super.setConstraints()

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(-9)
            make.trailing.equalTo(self).offset(-15)
            make.leading.equalTo(self).offset(15)
        }
        
        datelabel.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(9)
            make.leading.equalTo(self).offset(15)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(datelabel)
            make.leading.equalTo(datelabel.snp.trailing).offset(3)
            make.trailing.equalTo(self).offset(-15)
        }
        
    }
}
