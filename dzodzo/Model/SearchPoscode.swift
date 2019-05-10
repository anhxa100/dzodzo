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

        print("ID \(id)")
        print("NAME \(name)")
    }
}


//class SearchPoscode {
//    let id, poscode, name, address: String
//
//    init?(json: JSON) {
//        guard let _id = json["id"] as? String else {return nil}
//        guard let _poscode = json["poscode"] as? String else {return nil}
//        guard let _name = json["name"] as? String else {return nil}
//        guard let _address = json["address"] as? String else {return nil}
//        self.id = _id
//        self.poscode = _poscode
//        self.name = _name
//        self.address = _address
//
//        print("NAME: \(name)")
//    }
//}

//struct SearchPoscode: Decodable {
//    var id: String
//    var poscode: String
//    var name : String
//    var address: String
//}
