//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

private enum CellIdentifier {
    static let cell = "Cell"
}

private enum NibName {
    static let itemListTableViewCell = "ItemListTableViewCell"
}

private enum SegueIdentifier {
    static let edit = "unwindByItemEdit"
    static let itemEdit = "itemEdit"
    static let segueId = "unwindByItemAdd"
}

final class ItemListViewController: UIViewController {

    private let realm = try! Realm()
    @IBOutlet private weak var itemListTableView: UITableView!
    private var itemList: Results<CheckListItem>!
    /// 編集するcellのindexPathを保存
    private var selectedIndexPathRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        setRealm()
    }

    private func setUpNib() {
        let nib = UINib(nibName: NibName.itemListTableViewCell, bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: CellIdentifier.cell)
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
        try! realm.write {
            realm.add(addItem)
        }
    }

    /// itemNameを更新
    private func editRealm(itemName: String, isChecked: Bool) {
        try! realm.write {
            itemList[selectedIndexPathRow!].itemName = itemName
            itemList[selectedIndexPathRow!].isChecked = isChecked
        }
    }

    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == SegueIdentifier.segueId else { return }
        let addItemVC = unwindSegue.source as! ItemAddViewController
        addRealm(itemName: addItemVC.betaCheckItemName, isChecked: false)
        itemListTableView.reloadData()
    }

    /// Segueで渡されたeditedItemName変数を基にeditRealm関数でrealmデータを更新し、TableViewをリロード
    @IBAction func unwindToVCFromEditVC(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == SegueIdentifier.edit else { return }
        let itemEditVC = unwindSegue.source as! ItemEditViewController
        editRealm(itemName: itemEditVC.editedItemName, isChecked: itemList[selectedIndexPathRow!].isChecked)
        itemListTableView.reloadData()
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell, for: indexPath) as! ItemListTableViewCell
        let item = itemList[indexPath.row]
        if item.isChecked {
            cell.checkImageView.image = UIImage(named: "check")
        } else {
            cell.checkImageView.image = nil
        }
        cell.itemTitle.text = item.itemName
        return cell
    }

    /// タップしたチェック項目のチェックマーク状態を反転させる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        try! realm.write {
            itemList[indexPath.row].isChecked.toggle()
        }
        itemListTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    /// 編集前のタスク名をitemEditVCに渡す
    /// 編集するCellのindexPathを取得する
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPathRow = indexPath.row
        performSegue(withIdentifier: SegueIdentifier.itemEdit,
                     sender: itemList[indexPath.row].itemName)
    }

    /// セルを左スワイプしたあとDeleteボタンを押し、Detaの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(itemList[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.itemEdit {
            let navigationVC =  segue.destination as! UINavigationController
            let itemEditVC = navigationVC.topViewController as! ItemEditViewController
            itemEditVC.selectedItemName = sender as! String
        }
    }
}
