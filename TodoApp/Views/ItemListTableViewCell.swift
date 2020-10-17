//
//  ItemListTableViewCell.swift
//  TodoApp
//
//  Created by koji torishima on 2020/09/06.
//  Copyright © 2020 LeanjoyFC. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//以下、追記箇所
    weak var delegate: ToNextViewDelegate?
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.delegate?.toNextView()
    }
    
}

protocol ToNextViewDelegate: AnyObject {
        func toNextView()
    }
