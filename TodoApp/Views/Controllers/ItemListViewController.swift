//
//  ItemListViewController.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit
import RealmSwift

// どの画面からの遷移してきたかを示す
private enum SegueMode {
    case add    // 追加画面
    case other  // どの画面でもない
}

final class ItemListViewController: UIViewController {
    
    @IBOutlet private weak var itemListTableView: UITableView!
    
    // チェックリスト
    private var checkListItems: [CheckListItem] = []
    
    var itemList: Results<CheckListItem2>!
    
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
        
        let segueIdentifier     = unwindSegue.identifier
        var segueMode:SegueMode = .other
        
        // unwindSegueのidentifierでsegueModeに値を入れる
        // 追加画面から遷移してきた場合
        if segueIdentifier == "unwindByItemAdd" {
            segueMode = .add
        }
        
        // 新規データの追加、既存データの更新、などを行う
        switch segueMode {
        case .add:
            let addItemVC = unwindSegue.source as! ItemAddViewController

            let item = CheckListItem(name: addItemVC.testCheckItem, check: false)
            checkListItems.append(item)

            itemListTableView.reloadData()
        case .other:
            break
        }
    }
    
    func setRealm() {
        let realm = try! Realm()
        itemList = realm.objects(CheckListItem2.self)
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
        itemListTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
