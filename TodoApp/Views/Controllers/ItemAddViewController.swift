//
//  ItemAddViewController.swift
//  TodoApp
//
//  Created by Nekokichi on 2020/09/09.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

final class ItemAddViewController: UIViewController {
    
    @IBOutlet private weak var itemTextField: UITextField!
    // 新規追加用のチェック項目
    private(set) var betaCheckItemName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1文字も入力されてなければ、アラートで警告し、処理を中断させる
    @IBAction func addCheckItem(_ sender: Any) {
        if itemTextField.text!.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "1文字以上を入力してください",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))

            present(alert, animated: true, completion:  nil)
            return
        }

        betaCheckItemName = itemTextField.text!
        performSegue(withIdentifier: IdentifierType.segueId, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
