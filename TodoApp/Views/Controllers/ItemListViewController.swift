//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

private struct CheckListItem {
    var name : String
    var check: Bool
}

final class ItemListViewController: UIViewController {
    
    @IBOutlet private weak var itemListTableView: UITableView!
    
    // チェックリスト
    private var checkListItems: [CheckListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // チェックリストの初期化
        checkListItems = [
            CheckListItem(name: "リンゴ", check: false),
            CheckListItem(name: "メロン", check: false),
            CheckListItem(name: "バナナ", check: true),
            CheckListItem(name: "パイナップル", check: true),
            CheckListItem(name: "オレンジ", check: true)
        ]
        
        setUpNib()
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
            let item = CheckListItem(name: addItemVC.testCheckItem, check: false)
            checkListItems.append(item)
            itemListTableView.reloadData()
        }
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemListTableViewCell
        // testItemDataのcheckがtrueかを判断したい
        if checkListItems[indexPath.row].check {
            cell.checkImageView.image = UIImage(named: "check")
        } else {
            cell.checkImageView.image = nil
        }
        cell.itemTitle.text = checkListItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップしたチェック項目のチェックマーク状態を反転
        checkListItems[indexPath.row].check.toggle()
    }
}

