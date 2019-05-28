//
//  PaytypeCell.swift
//  dzodzo
//
//  Created by anhxa100 on 5/28/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class PaytypeCell: UITableViewCell {

    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var soGiaoDichLB: UILabel!
    @IBOutlet weak var sotienTTLB: UILabel!
    @IBOutlet weak var soGiaoDichHoanTraLB: UILabel!
    @IBOutlet weak var soTienHoanTraLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
