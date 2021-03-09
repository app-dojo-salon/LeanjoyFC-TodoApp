//
//  ConfigrationViewCell.swift
//  TodoApp
//
//  Created by 小川卓馬 on 2021/01/31.
//  Copyright © 2021 LeanjoyFC. All rights reserved.
//

import UIKit

class ConfigrationViewCell: UITableViewCell {
    
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
