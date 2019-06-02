//
//  Time.swift
//  dzodzo
//
//  Created by anhxa100 on 6/2/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation


class Time {
    let calendar = Calendar.current
    var date = Date()
    let format = DateFormatter()
    //Ngày kế tiếp
    func convertNextDate(){
        let myDate = format.date(from: dateChart.text!)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = format.string(from: tomorrow!)
        dateChart.text = somedateString
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalArray = dayData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalWithoutchart = dayData
            self?.getDataWithoutChart()
        })
        print(" \(somedateString)")
        
    }
}
