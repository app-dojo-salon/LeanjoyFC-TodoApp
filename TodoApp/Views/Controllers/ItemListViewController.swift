//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

final class ItemListViewController: UIViewController {
    
    private let realm = try! Realm()
    
    @IBOutlet private weak var itemListTableView: UITableView!
    private var itemList: Results<CheckListItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        setRealm()
    }
    
    private func setUpNib() {
        let nib = UINib(nibName: IdentifierType.nibId, bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: IdentifierType.cellId)
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
    
    private func setRealm() {
        itemList = realm.objects(CheckListItem.self)
    }
    
    private func addRealm(itemName: String, isChecked: Bool) {
        let addItem = CheckListItem()
        addItem.itemName = itemName
        addItem.isChecked = isChecked
        try! realm.write() {
            realm.add(addItem)
        }
        
    }
    
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == IdentifierType.segueId else { return }
        let addItemVC = unwindSegue.source as! ItemAddViewController
        /// append
        addRealm(itemName: addItemVC.testCheckItem, isChecked: false)
        
        itemListTableView.reloadData()
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierType.cellId, for: indexPath) as! ItemListTableViewCell
        let item = itemList[indexPath.row]
        if item.isChecked {
            cell.checkImageView.image = UIImage(named: "check")
        } else {
            cell.checkImageView.image = nil
        }
        cell.itemTitle.text = item.itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップしたチェック項目のチェックマーク状態を反転
        try! realm.write() {
            itemList[indexPath.row].isChecked.toggle()
        }
        itemListTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
