//
//  IntAxisValueFormatter.swift
//  dzodzo
//
//  Created by anhxa100 on 5/20/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Charts

public class IntAxisValueFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))"
    }
}
