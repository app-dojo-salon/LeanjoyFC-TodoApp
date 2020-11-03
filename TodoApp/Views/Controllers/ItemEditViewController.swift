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
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    var selectedItemName: String = ""
    private(set) var editedItemName: String = ""
    private let realm = try! Realm()
    
    private enum SegueIdentifier {
        static let edit = "unwindByItemEdit"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextField.text = selectedItemName //編集前のタスク名を表示
    }
    
    // TextFieldに文字が入力されているか確認し、SaveButtonの無効化と有効化を切り替える
    @IBAction func checkTextFieldIsEmpty(_ sender: Any) {
        if editTextField.text == "" {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        //unwindSegueでItemListViewControllerに戻る
        editedItemName = editTextField.text!
        performSegue(withIdentifier: SegueIdentifier.edit, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
