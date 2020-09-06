//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

final class ItemListViewController: UIViewController {
    
    @IBOutlet private weak var itemListTableView: UITableView!
    private let itemData: [String] = ["リンゴ", "メロン", "バナナ", "パイナップル", "オレンジ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
    }
    
    private func setUpNib() {
        let nib = UINib(nibName: "ItemListTableViewCell", bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: "Cell")
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemListTableViewCell
        let item = itemData[indexPath.row]
        cell.itemTitle.text = item
        return cell
    }
}

