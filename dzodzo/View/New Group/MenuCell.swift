//
//  MenuCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/29/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var iconMenu: UIImageView!
    @IBOutlet weak var menuLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
