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
    private var editCellIndexPath: Int?  //編集するcellのindexPathを保存する変数
    private enum SegueIdentifier {
        static let edit = "unwindByItemEdit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        setRealm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
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
    
    //　itemNameを更新する関数
    private func editRealm(itemName: String, isChecked: Bool) {
        let editItem = realm.objects(CheckListItem.self)
        try! realm.write {
            editItem[editCellIndexPath!].itemName = itemName
            editItem[editCellIndexPath!].isChecked = isChecked
        }
    }
    
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == IdentifierType.segueId else { return }
        let addItemVC = unwindSegue.source as! ItemAddViewController
        /// append
        addRealm(itemName: addItemVC.betaCheckItemName, isChecked: false)
        itemListTableView.reloadData()
    }
    
    // Segueで渡されたeditedItemName変数を基にeditRealm関数でrealmデータを更新し、TableViewをリロード
    @IBAction func unwindToVCFromEditVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == SegueIdentifier.edit else { return }
        let itemEditVC = unwindSegue.source as! ItemEditViewController
        print(itemEditVC.editedItemName)
        editRealm(itemName: itemEditVC.editedItemName, isChecked: itemList[editCellIndexPath!].isChecked)
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
    
    //編集前のタスク名をitemEditVCに渡す
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        editCellIndexPath = indexPath.row //編集するCellのindexPathを取得
        performSegue(withIdentifier: "itemEdit", sender: itemList[indexPath.row].itemName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemEdit" {
            let nav =  segue.destination as! UINavigationController
            let itemEditVC = nav.viewControllers[nav.viewControllers.count-1] as! ItemEditViewController
            itemEditVC.selectedItemName = sender as! String
        }
    }
}
