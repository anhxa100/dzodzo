//
//  ReportRevenueCategory.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

struct ReportRevenueCategory {
    var posgroupcode: String
    var poscode: String
    var itemcategoryid: String
    var quantity: String
    var totalcost: String
    var totalamount: String
    var totaldiscount: String
    var categoryname: String
    
    init(_ Dic: [String: Any]) {
        self.posgroupcode = Dic["posgroupcode"] as? String ?? ""
        self.poscode = Dic["poscode"] as? String ?? ""
        self.itemcategoryid = Dic["itemid"] as? String ?? ""
        self.quantity = Dic["quantity"] as? String ?? ""
        self.totalcost = Dic["totalcost"] as? String ?? ""
        self.totalamount = Dic["totalamount"] as? String ?? ""
        self.totaldiscount = Dic["totaldiscount"] as? String ?? ""
        self.categoryname = Dic["categoryname"] as? String ?? ""
    }
}
