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
    // まだ追加すると確定してないので、beta、を付けた
    private(set) var betaCheckItem = CheckListItem()
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCheckItem(_ sender: Any) {
        // 1文字も入力されてなければ、アラートで警告し、処理を中断
        if itemTextField.text!.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "1文字以上を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion:  nil)
            return
        }
        
        performSegue(withIdentifier: IdentifierType.segueId, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
