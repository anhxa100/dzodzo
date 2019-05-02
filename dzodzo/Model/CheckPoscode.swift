//
//  CheckPoscode.swift
//  dzodzo
//
//  Created by anhxa100 on 4/26/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

//class CheckPoscode {
//    let poscode: String
//    let posgroupcode: String
//
//    init( _poscode: String, _posgroupcode: String) {
//        self.poscode = _poscode
//        self.posgroupcode = _posgroupcode
//    }
//
//
//}

class CheckPoscode {
        var poscode: String
        var posgroupcode: String
    
    init (_ Dictionary: [String: Any]) {
        self.poscode = Dictionary["poscode"] as? String ?? ""
        self.posgroupcode = Dictionary["posgroupcode"] as? String ?? ""
    }
}
