//
//  MaterialsItemDailyCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/28/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class MaterialsItemDailyCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLB: UILabel!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var itemQuantityLB: UILabel!
    @IBOutlet weak var materialsQuantityOneItemLB: UILabel!
    @IBOutlet weak var materialsQuantityLB: UILabel!
    @IBOutlet weak var unitLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
