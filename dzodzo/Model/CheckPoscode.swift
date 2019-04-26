//
//  CheckPoscode.swift
//  dzodzo
//
//  Created by anhxa100 on 4/26/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

class CheckPoscode {
    let poscode: String
    let posgroupcode: String
    
    init?(json: JSON) {
        guard let _poscode = json["poscode"] as? String else {return nil}
        guard let _posgroupcode = json["posgroupcode"] as? String else {return nil}
        
        poscode = _poscode
        posgroupcode = _posgroupcode
        
        print(json)
    
    }
    
    
}
