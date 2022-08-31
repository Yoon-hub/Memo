//
//  BaseViewController.swift
//  MemoProject
//
//  Created by 최윤제 on 2022/08/31.
//
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configue()
        view.backgroundColor = .bgColor

    }
  
    func configue() { }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
