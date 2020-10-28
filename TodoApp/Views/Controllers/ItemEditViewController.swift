//
//  ItemEditViewController.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2020/10/12.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

final class ItemEditViewController: UIViewController {
    
    @IBOutlet private weak var editTextField: UITextField!
    
    var editItemName: String = ""
    var editedItemName: String = ""
    var itemList:Results<CheckListItem>?
    private let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        editTextField.text = editItemName //編集前のタスク名を表示
        
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        // 1文字も入力されてなければ、アラートで警告し、処理を中断
        if editTextField.text!.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "1文字以上を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion:  nil)
            return
        }
        //unwindSegueでItemListViewControllerに戻る
        editedItemName = editTextField.text!
        print(editedItemName)
        performSegue(withIdentifier: IdentifierType.editSegueId, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
