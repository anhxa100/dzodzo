//
//  TotalDashboard.swift
//  dzodzo
//
//  Created by anhxa100 on 5/6/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation


struct ReportRevenueTotal {

    var posgroupcode: String
    var poscode: String
    var totalamount: String
    var totaldiscount: String
    var paybackamount: String
    var taxamount: String
    var date: String


    init (_ Dictionary: [String: Any]) {
        self.posgroupcode = Dictionary["posgroupcode"] as? String ?? ""
        self.poscode = Dictionary["poscode"] as? String ?? ""
        self.totalamount = Dictionary["totalamount"] as? String ?? ""
        self.totaldiscount = Dictionary["paybackamount"] as? String ?? ""
        self.paybackamount = Dictionary["paybackamount"] as? String ?? ""
        self.taxamount = Dictionary["taxamount"] as? String ?? ""
        self.date = Dictionary["date"] as? String ?? ""
        
        
        

//         Chuyển dữ liệu kiểu string sang kiểu số
//        print("TOTAL date:\(taxamount)")
//        let n = (taxamount as NSString).doubleValue
//        print(n)
//        print("Dictionary: \(Dictionary)")
    }
}


