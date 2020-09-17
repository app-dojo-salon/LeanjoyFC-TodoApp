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
    
    let realm = try! Realm()
    let itemModel = ItemModel()
    
    // テストデータを追加させるため、let->var、に変更
    private var itemData: [String] = ["リンゴ", "メロン", "バナナ", "パイナップル", "オレンジ"]
    // 一旦使っていません。（takuma）
    
    
    var itemList: Results<ItemModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        
        itemList = realm.objects(ItemModel.self)
        
    }
    
    private func setUpNib() {
        let nib = UINib(nibName: "ItemListTableViewCell", bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: "Cell")
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
    
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        // 追加ボタンを押下した場合
        if unwindSegue.identifier == "unwindByItemAdd" {
            let addItemVC = unwindSegue.source as! ItemAddViewController
            itemData.append(addItemVC.testCheckItem)
            
            let itemModel = ItemModel()
            itemModel.name = addItemVC.testCheckItem
            try! realm.write {
                realm.add(itemModel)
            }
            
            
            
            // printでの出力、tableViewでの表示、両方で追加されたかを確認
            print(itemData)
            itemListTableView.reloadData()
        }
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemListTableViewCell
//        let item = itemData[indexPath.row]
        
        let item: ItemModel = self.itemList[(indexPath as NSIndexPath).row]
        cell.itemTitle.text = item.name
        return cell
    }
}

