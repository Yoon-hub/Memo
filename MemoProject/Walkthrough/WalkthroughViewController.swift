//
//  FirstView.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/04.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .firstColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let okButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .tintColor
        view.tintColor = .white
        view.layer.cornerRadius = 10
        view.setTitle("확인", for: .normal)
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.numberOfLines = 0
        view.text = """
안녕하세요! 처음 오셨군요
환영합니다:)

당신만의 메모를 작성하고
관리해보세요!
"""
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
    }
    
    func configue() {
        
        view.backgroundColor = .black.withAlphaComponent(0.6)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapGestureClicked))
        view.addGestureRecognizer(tapGesture)
        okButton.addTarget(self, action: #selector(tapGestureClicked), for: .touchUpInside)
        view.addSubview(popupView)
        popupView.addSubview(okButton)
        popupView.addSubview(label)
        
        popupView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(view).multipliedBy(0.38)
        }
        
        okButton.snp.makeConstraints { make in
            make.trailing.equalTo(popupView.snp.trailing).offset(-26)
            make.leading.equalTo(popupView.snp.leading).offset(26)
            make.bottom.equalTo(popupView.snp.bottom).offset(-26)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(popupView.snp.top).offset(26)
            make.leading.equalTo(popupView.snp.leading).offset(26)
            make.trailing.equalTo(popupView.snp.trailing).offset(-26)
            make.bottom.equalTo(okButton.snp.top).offset(-26)
        }
    }
    
    @objc
    func tapGestureClicked() {
        dismiss(animated: true)
    }
}

