//
//  FeedbackCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/28/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class FeedbackCell: UITableViewCell {

    @IBOutlet weak var creatDateLB: UILabel!
    @IBOutlet weak var r1LB: UILabel!
    @IBOutlet weak var r2LB: UILabel!
    @IBOutlet weak var r3LB: UILabel!
    @IBOutlet weak var r4LB: UILabel!
    @IBOutlet weak var r5LB: UILabel!
    @IBOutlet weak var cm1LB: UILabel!
    @IBOutlet weak var cm2LB: UILabel!
    @IBOutlet weak var cm3LB: UILabel!
    @IBOutlet weak var cm4LB: UILabel!
    @IBOutlet weak var cm5LB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
