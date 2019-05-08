//
//  Calendar.swift
//  dzodzo
//
//  Created by anhxa100 on 5/7/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
let weekDay = calendar.component(.weekday, from: date)
let month = calendar.component(.month, from: date)
let year = calendar.component(.year, from: date)

