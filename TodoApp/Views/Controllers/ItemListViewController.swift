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
        let realm = try! Realm()
        itemList = realm.objects(CheckListItem.self)
    }
    
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == IdentifierType.segueId else { return }
        let addItemVC = unwindSegue.source as! ItemAddViewController
        /// append
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
        cell.checkImageView.image = nil
        cell.checkImageView.image = UIImage(named: "check")
        cell.itemTitle.text = item.itemName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemList[indexPath.row].isChecked.toggle()
    }
}
