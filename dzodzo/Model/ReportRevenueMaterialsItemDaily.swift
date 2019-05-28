//
//  ReportRevenueMaterialsItemDaily.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

struct ReportRevenueMaterialsItemDaily {
    var itemid: String
    var itemname: String
    var id_materials: String
    var name: String
    var unit: String
    var item_quantity: String
    var materials_quantity_one_item: String
    var materials_quantity: String
    var date : String
    
    init(_ Dic: [String: Any]) {
        self.itemid = Dic["itemid"] as? String ?? ""
        self.itemname = Dic["itemname"] as? String ?? ""
        self.id_materials = Dic["id_materials"] as? String ?? ""
        self.name = Dic["name"] as? String ?? ""
        self.unit = Dic["unit"] as? String ?? ""
        self.item_quantity = Dic["item_quantity"] as? String ?? ""
        self.materials_quantity_one_item = Dic["materials_quantity_one_item"] as? String ?? ""
        self.materials_quantity = Dic["materials_quantity"] as? String ?? ""
        self.date = Dic["date"] as? String ?? ""
    }
    
}
