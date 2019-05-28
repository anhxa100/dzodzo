//
//  ReportRevenuePayType.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

struct ReportRevenuePayType {
    var name: String
    var soGiaoDich: String
    var soTienTT: String
    var soGiaoDichHoanTra: String
    var soTienHT: String
    
    init(_ Dic: [String: Any]) {
        self.name = Dic["NAME"] as? String ?? ""
        self.soGiaoDich = Dic["SOGIAODICH"] as? String ?? ""
        self.soTienTT = Dic["SOTIENTT"] as? String ?? ""
        self.soGiaoDichHoanTra = Dic["SOGIAODICHHT"] as? String ?? ""
        self.soTienHT = Dic["SOTIENHT"] as? String ?? ""
    }
}
