//
//  items.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2020/09/16.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import RealmSwift

class CheckListItem: Object {
    @objc dynamic var itemName: String = ""
    @objc dynamic var isChecked: Bool = false
}
