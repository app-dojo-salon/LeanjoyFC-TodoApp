//
//  items.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2020/09/16.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import RealmSwift

class ItemModel: Object {
    @objc dynamic var name: String?
    // RealmSwiftでの保存用のclass作成（takuma）
}
