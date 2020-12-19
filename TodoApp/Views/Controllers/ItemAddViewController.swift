//
//  ItemAddViewController.swift
//  TodoApp
//
//  Created by Nekokichi on 2020/09/09.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

private enum SegueIdentifier {
    static let segueId = "unwindByItemAdd"
}

final class ItemAddViewController: UIViewController {

    @IBOutlet private weak var itemTextField: UITextField!
    @IBOutlet private weak var saveButton: UIBarButtonItem!

    /// 新規追加用のチェック項目
    private(set) var betaCheckItemName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
    }

    /// TextFieldに文字が入力されているか確認し、SaveButtonの無効化と有効化を切り替え
    @IBAction func checkTextFieldIsEmpty(_ sender: Any) {
        if itemTextField.text!.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }

    /// unwindSegueでItemListViewControllerに戻る
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        betaCheckItemName = itemTextField.text!
        performSegue(withIdentifier: SegueIdentifier.segueId, sender: nil)
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
