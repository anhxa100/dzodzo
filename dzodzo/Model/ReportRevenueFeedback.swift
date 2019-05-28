//
//  ReportRevenueFeedback.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
struct ReportRevenueFeedback {
    var create_date: String
    var r1: String
    var r2: String
    var r3: String
    var r4: String
    var r5: String
    var cm1: String
    var cm2: String
    var cm3: String
    var cm4: String
    var cm5: String
    
    init(_ Dic: [String: Any]) {
        self.create_date = Dic["create_date"] as? String ?? ""
        self.r1 = Dic["r1"] as? String ?? ""
        self.r2 = Dic["r2"] as? String ?? ""
        self.r3 = Dic["r3"] as? String ?? ""
        self.r4 = Dic["r4"] as? String ?? ""
        self.r5 = Dic["r5"] as? String ?? ""
        self.cm1 = Dic["cm1"] as? String ?? ""
        self.cm2 = Dic["cm2"] as? String ?? ""
        self.cm3 = Dic["cm3"] as? String ?? ""
        self.cm4 = Dic["cm4"] as? String ?? ""
        self.cm5 = Dic["cm5"] as? String ?? ""
    }

}
