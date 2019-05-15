//
//  DataRealm.swift
//  dzodzo
//
//  Created by anhxa100 on 5/15/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import RealmSwift

class DataRealm: Object {
    @objc dynamic var totalamount: Double = Double(0.00)
    @objc dynamic var totaldiscount: Double = Double(0.00)
    @objc dynamic var paybackamount: Double = Double(0.00)
    @objc dynamic var taxamount: Double = Double(0.00)
    @objc dynamic var date: Date = Date()
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

}
