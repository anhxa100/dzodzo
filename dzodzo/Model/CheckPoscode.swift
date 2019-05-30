//
//  CheckPoscode.swift
//  dzodzo
//
//  Created by anhxa100 on 4/26/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation


class CheckPoscode {
    var poscode: String
    var posgroupcode: String
    var startdate: String
    var nameStaff: String
    var position: String
    
    init (_ Dictionary: [String: Any]) {
        self.poscode = Dictionary["poscode"] as? String ?? ""
        self.posgroupcode = Dictionary["posgroupcode"] as? String ?? ""
        self.startdate = Dictionary["date_create"] as? String ?? ""
        self.nameStaff = Dictionary["nameStaff"] as? String ?? ""
        self.position = Dictionary["position"] as? String ?? ""
        print("testposcode: \(poscode)")
        print("testposgroupcode: \(posgroupcode)")
    }
    
}

