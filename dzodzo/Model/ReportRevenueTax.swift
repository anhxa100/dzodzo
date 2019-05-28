//
//  ReportRevenueTax.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

struct ReportRevenueTax {
    var taxname: String
    var totaltax: String
    
    init(_ Dic: [String: Any]) {
        self.taxname = Dic["taxname"] as? String ?? ""
        self.totaltax = Dic["totaltax"] as? String ?? ""
    }
}
