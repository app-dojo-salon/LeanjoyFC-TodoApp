//
//  ConfigrationViewController.swift
//  TodoApp
//
//  Created by 守屋譲司 on 2021/01/07.
//  Copyright © 2021 LeanjoyFC. All rights reserved.
//

import UIKit

private enum CellIdentifier {
    static let configrationCell = "ConfigrationCell"
}

private enum NibName {
    static let configrationViewCell = "ConfigrationViewCell"
}

class ConfigrationViewController: UIViewController {
    @IBOutlet weak var configrationTableView: UITableView!
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    var infoList: [(title: String, value: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        infoList.append(("アプリバージョン", version))
        
    }
    
    private func setUpNib() {
        let nib = UINib(nibName: NibName.configrationViewCell, bundle: nil)
        configrationTableView.register(nib, forCellReuseIdentifier: CellIdentifier.configrationCell)
        configrationTableView.delegate = self
        configrationTableView.dataSource = self
    }

}

extension ConfigrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.configrationCell) as! ConfigrationViewCell
        let item = infoList[indexPath.row]
        cell.infoTitle.text = item.title
        cell.infoValue.text = item.value
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "情報"
    }

}
