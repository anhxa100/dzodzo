//
//  CategoryCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/28/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categorynameLB: UILabel!
    @IBOutlet weak var quantityLB: UILabel!
    @IBOutlet weak var totalamountLB: UILabel!
    @IBOutlet weak var totaldiscountLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
