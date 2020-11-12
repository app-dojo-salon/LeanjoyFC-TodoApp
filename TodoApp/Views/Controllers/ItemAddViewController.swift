//
//  ItemAddViewController.swift
//  TodoApp
//
//  Created by Nekokichi on 2020/09/09.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

private enum ItemAddVCIdentifierType {
    static let segueId = "unwindByItemAdd"
}

final class ItemAddViewController: UIViewController {

    private enum AlertLanguage {
        static let ErrorTitle = "エラー"
        static let ErrorMessage = "1文字以上を入力してください"
        static let ok = "ok"
    }
    
    @IBOutlet private weak var itemTextField: UITextField!
    /// 新規追加用のチェック項目
    private(set) var betaCheckItemName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 1文字も入力されてなければ、アラートで警告し、処理を中断
    @IBAction func addCheckItem(_ sender: Any) {
        if itemTextField.text!.isEmpty {
            let alert = UIAlertController(title: AlertLanguage.ErrorTitle,
                                          message: AlertLanguage.ErrorMessage,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: AlertLanguage.ok,
                                          style: .cancel,
                                          handler: nil))

            present(alert, animated: true, completion:  nil)
            return
        }

        betaCheckItemName = itemTextField.text!
        performSegue(withIdentifier: ItemAddVCIdentifierType.segueId, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
