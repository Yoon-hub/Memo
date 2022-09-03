//
//  AddViewController.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/09/03.
//

import UIKit

class AddViewController: BaseViewController {
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .bgColor
        view.font = .boldSystemFont(ofSize: 15)
        view.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.scrollIndicatorInsets = view.textContainerInset
        return view
    }()
    
    var task: UserMemo?
    var modify = false
    var backButtonTitle = "메모"
    
    override func configue() {
        super.configue()
        
        navigationConfigue()
        view.addSubview(textView)
        textView.delegate = self
        textView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        if let task = task {
            if let content = task.content {
                textView.text = task.title + "\n" + task.content!
            } else {
                textView.text = task.title
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let text = textView.text, !text.isEmpty, text.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        IfManager.shared.editText(text: text)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !modify {
            textView.becomeFirstResponder()
        }
    }
    
    @objc
    func shareButtonClicked() {
        
    }
    
    @objc
    func completeButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func navigationConfigue() {
        navigationController?.navigationBar.topItem?.title = "\(backButtonTitle)"
        navigationController?.navigationBar.tintColor = .tintColor

    }
    
}

extension AddViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        navigationItem.rightBarButtonItems = [completeButton, shareButton]
        return true
    }
    
}
