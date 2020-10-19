//
//  ItemEditViewController.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2020/10/12.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

final class ItemEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
