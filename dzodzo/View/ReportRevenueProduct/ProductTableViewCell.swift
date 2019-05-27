//
//  ProductTableViewCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemnameLB: UILabel!
    @IBOutlet weak var quantityLB: UILabel!
    @IBOutlet weak var totalamountLB: UILabel!
    @IBOutlet weak var totoaldiscountLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
