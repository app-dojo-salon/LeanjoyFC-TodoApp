//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

private struct CheckItem {
    var name : String
    var check: Bool
}

final class ItemListViewController: UIViewController {
    
    @IBOutlet private weak var itemListTableView: UITableView!
    
    // テスト用のチェックリスト
    private var testItemData: [CheckItem] = []
    // チェックリスト
    private var itemData    : [String] = ["リンゴ", "メロン", "バナナ", "パイナップル", "オレンジ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // チェックリストの初期化
        testItemData = [
            CheckItem(name: "リンゴ", check: false),
            CheckItem(name: "メロン", check: false),
            CheckItem(name: "バナナ", check: false),
            CheckItem(name: "パイナップル", check: false),
            CheckItem(name: "オレンジ", check: false)
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
        // 注意!! まだstruct型に対応してないので、エラーが起きます！
        // 追加ボタンを押下した場合
        if unwindSegue.identifier == "unwindByItemAdd" {
            let addItemVC = unwindSegue.source as! ItemAddViewController
            itemData.append(addItemVC.testCheckItem)
            itemListTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップしたチェック項目のチェックマーク状態を反転
        testItemData[indexPath.row].check.toggle()
    }
}

