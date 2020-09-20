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
    
    // テストデータを追加させるため、let->var に変更  // 一旦使っていません。（takuma）
    private var itemData: [String] = ["リンゴ", "メロン", "バナナ", "パイナップル", "オレンジ"]
    
    var itemList: Results<CheckListItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNib()
        setRealm()
        
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
            
            // printでの出力、tableViewでの表示、両方で追加されたかを確認
            print(itemData)
            itemListTableView.reloadData()
        }
    }
    
    func setRealm() {
        let realm = try! Realm()
        itemList = realm.objects(CheckListItem.self)
    }
    
    
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemListTableViewCell
        
        let item = itemList[indexPath.row]
        cell.itemTitle.text = item.itemName
        
        return cell
    }
}
