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
    
    // チェックリスト
    private var checkListItems: [CheckListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNib()
    }
    
    private func setUpNib() {
        let nib = UINib(nibName: "ItemListTableViewCell", bundle: nil)
        itemListTableView.register(nib, forCellReuseIdentifier: "Cell")
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
    
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue) {
        
        // どの画面からの遷移してきたかを示す
        enum SegueMode {
            case add    // 追加画面
            case other  // どの画面でもない
        }
        
        let segueIdentifier     = unwindSegue.identifier
        var segueMode:SegueMode = .other
        
        // unwindSegueのidentifierでsegueModeに値を入れる
        switch segueIdentifier {
        case "unwindByItemAdd": // 追加画面から遷移してきた場合
            segueMode = .add
        default: break
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

