//
//  ReportRevenueProduct.swift
//  dzodzo
//
//  Created by anhxa100 on 5/24/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

struct ReportRevenueProduct {
    var posgroupcode: String
    var poscode: String
    var itemid: String
    var quantity: String
    var totalcost: String
    var s_totalamount: String
    var totalamount: String
    var totaldiscount: String
    var itemname: String
    var itemcode: String
    var categoryname: String
    
    init(_ Dic: [String: Any]) {
        self.posgroupcode = Dic["posgroupcode"] as? String ?? ""
        self.poscode = Dic["poscode"] as? String ?? ""
        self.itemid = Dic["itemid"] as? String ?? ""
        self.quantity = Dic["quantity"] as? String ?? ""
        self.totalcost = Dic["totalcost"] as? String ?? ""
        self.s_totalamount = Dic["S_totalamount"] as? String ?? ""
        self.totalamount = Dic["totalamount"] as? String ?? ""
        self.totaldiscount = Dic["totaldiscount"] as? String ?? ""
        self.itemname = Dic["itemname"] as? String ?? ""
        self.itemcode = Dic["itemcode"] as? String ?? ""
        self.categoryname = Dic["categoryname"] as? String ?? ""
    }
}
