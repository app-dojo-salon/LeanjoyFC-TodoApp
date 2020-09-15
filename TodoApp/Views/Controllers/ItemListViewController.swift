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
    
    // testItemData用のキー
    // 課題チャレンジの動画を参考に作成
    fileprivate let keyName  = "keyName"
    fileprivate let keyCheck = "keyCheck"
    
    // チェックマーク状態を示すBool値を加えたチェックリスト
    private var testItemData: [Dictionary<String,Any>] = []
    private var itemData: [String] = ["リンゴ", "メロン", "バナナ", "パイナップル", "オレンジ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // チェックリストの初期化
        testItemData = [
            [keyName:"リンゴ",keyCheck:false],
            [keyName:"メロン",keyCheck:false],
            [keyName:"バナナ",keyCheck:false],
            [keyName:"パイナップル",keyCheck:false],
            [keyName:"オレンジ",keyCheck:false],
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
        // testItemDataのValueはAnyで宣言されてるので、if-let文でBoolに変換
        if let isChecked = testItemData[indexPath.row][keyCheck] as? Bool {
            // タップしたチェック項目のチェックマーク状態を反転
            testItemData[indexPath.row][keyCheck] = !isChecked
        }
    }
}

