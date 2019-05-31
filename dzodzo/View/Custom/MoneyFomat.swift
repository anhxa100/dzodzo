//
//  MoneyFomat.swift
//  dzodzo
//
//  Created by anhxa100 on 5/31/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

class MoneyFormat {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    // localize to your grouping and decimal separator
    currencyFormatter.locale = Locale.current
}
