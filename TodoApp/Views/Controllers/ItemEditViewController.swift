//
//  ItemEditViewController.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2020/10/12.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

private enum SegueIdentifier {
    static let edit = "unwindByItemEdit"
}

final class ItemEditViewController: UIViewController {
    
    @IBOutlet private weak var editTextField: UITextField!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    var selectedItemName: String = ""
    private(set) var editedItemName: String = ""
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        editTextField.text = selectedItemName
    }
    
    /// TextFieldに文字が入力されているか確認し、SaveButtonの無効化と有効化を切り替え
    @IBAction func checkTextFieldIsEmpty(_ sender: Any) {
        if editTextField.text!.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }

    /// unwindSegueでItemListViewControllerに戻る
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        editedItemName = editTextField.text!
        performSegue(withIdentifier: SegueIdentifier.edit, sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
