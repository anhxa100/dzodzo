//
//  ReportRevenueDiscount.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
struct ReportRevenueDiscount {
    var discount_name: String
    var totaldiscount: String
    var discount_desc: String
    var discountid: String
    var poscode: String
    var posgroupcode: String
    var date_log: String
    
    init(_ Dic: [String: Any]) {
        self.discount_name = Dic["discount_name"] as? String ?? ""
        self.totaldiscount = Dic["totaldiscount"] as? String ?? ""
        self.discount_desc = Dic["discount_desc"] as? String ?? ""
        self.discountid = Dic["discountid"] as? String ?? ""
        self.poscode = Dic["poscode"] as? String ?? ""
        self.posgroupcode = Dic["posgroupcode"] as? String ?? ""
        self.date_log = Dic["date_log"] as? String ?? ""
    }
}
