//
//  ItemAddViewController.swift
//  TodoApp
//
//  Created by Nekokichi on 2020/09/09.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

final class ItemAddViewController: UIViewController {
    
    @IBOutlet private weak var itemTextField: UITextField!
    // テストデータ
    // private修飾子をつけるために、varで定義
    private(set) var testCheckItem = "test"
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCheckItem(_ sender: Any) {
        performSegue(withIdentifier: "unwindByItemAdd", sender: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
