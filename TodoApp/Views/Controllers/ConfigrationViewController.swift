//
//  ConfigrationViewController.swift
//  TodoApp
//
//  Created by 守屋譲司 on 2021/01/07.
//  Copyright © 2021 LeanjoyFC. All rights reserved.
//

import UIKit

class ConfigrationViewController: UIViewController {
    @IBOutlet weak var configrationContentsView: UIView!
    @IBOutlet weak var appVersionLabel: UILabel!
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appVersionLabel.text = version
        setConfigrationContentsView()
    }
    
    func setConfigrationContentsView() {
        configrationContentsView.layer.borderColor = UIColor.systemGray4.cgColor
        configrationContentsView.layer.borderWidth = 1.0
    }
}
