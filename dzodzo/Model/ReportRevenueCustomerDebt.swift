//
//  ReportRevenueCustomerDebt.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
struct ReportRevenueCustomerDebt {
    var date: String
    var posgroupcode: String
    var poscode: String
    var total_debt: String
    var total_paid: String
    
    init(_ Dic: [String: Any]) {
        self.date = Dic["date"] as? String ?? ""
        self.posgroupcode = Dic["posgroupcode"] as? String ?? ""
        self.poscode = Dic["poscode"] as? String ?? ""
        self.total_debt = Dic["total_debt"] as? String ?? ""
        self.total_paid = Dic["total_paid"] as? String ?? ""
    }
}
