//
//  SearchPoscode.swift
//  dzodzo
//
//  Created by anhxa100 on 5/8/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

class SearchPoscode {
    var id: String
    var poscode: String
    var name : String
    var address: String
    
    init(_ Dictionary: [String: Any]) {
        self.id = Dictionary["id"] as? String ?? ""
        self.poscode = Dictionary["poscode"] as? String ?? ""
        self.name = Dictionary["name"] as? String ?? ""
        self.address = Dictionary["address"] as? String ?? ""
    }
    
}
