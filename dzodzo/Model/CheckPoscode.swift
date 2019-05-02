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
    
    init (_ Dictionary: [String: Any]) {
        self.poscode = Dictionary["poscode"] as? String ?? ""
        self.posgroupcode = Dictionary["posgroupcode"] as? String ?? ""
    }
    
}

