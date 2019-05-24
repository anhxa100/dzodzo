//
//  TotalDashBoardAPI.swift
//  dzodzo
//
//  Created by anhxa100 on 5/6/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class ReportRevenueTotalAPI {
    
    static func getRevenueTotalWithChart(pstartdate: String, penddate: String, success: @escaping ([ReportRevenueTotal])-> Void) {
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey),
        let pposgroupcode = UserDefaults.standard.string(forKey: UserDefaultKeys.posgroupKey),
        let pposcode = UserDefaults.standard.string(forKey: UserDefaultKeys.poscodeKey)
        else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "search_chart_report_revenue_total"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "4"),
            URLQueryItem(name: "P1", value: pposgroupcode),
            URLQueryItem(name: "P2", value: pposcode),
            URLQueryItem(name: "P3", value: pstartdate),
            URLQueryItem(name: "P4", value: penddate),
            ])
        
        guard let urlGetPos = componentsGetPost.url else {
            return
        }
        print("URL GETPOSTCODE/ GROUP: \(urlGetPos)")
        
        var urlRequest  = URLRequest(url: urlGetPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
        
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.isSuccess else {
                print("ERROR")
                return
            }

            guard let getposAPI = response.result.value as? [[String: Any]] else {return}

            var model = [ReportRevenueTotal]()
            for dic in getposAPI {
                model.append(ReportRevenueTotal(dic))
            }
            success(model)
            print("DATA with chart: \(model)")

        }
    }
    
    
    static func getRevenueTotal(pstartdate: String, penddate: String, success: @escaping ([ReportRevenueTotal])-> Void) {
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey),
            let pposgroupcode = UserDefaults.standard.string(forKey: UserDefaultKeys.posgroupKey),
            let pposcode = UserDefaults.standard.string(forKey: UserDefaultKeys.poscodeKey)
            else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "crud_search_all_report_revenue_total"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "4"),
            URLQueryItem(name: "P1", value: pposgroupcode),
            URLQueryItem(name: "P2", value: pposcode),
            URLQueryItem(name: "P3", value: pstartdate),
            URLQueryItem(name: "P4", value: penddate),
            ])
        
        guard let urlGetPos = componentsGetPost.url else {
            return
        }
        print("URL GETPOSTCODE/ GROUP: \(urlGetPos)")
        
        var urlRequest  = URLRequest(url: urlGetPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
        
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.isSuccess else {
                print("ERROR")
                return
            }
            
            guard let getposAPI = response.result.value as? [[String: Any]] else {return}
            
            var model = [ReportRevenueTotal]()
            for dic in getposAPI {
                model.append(ReportRevenueTotal(dic))
            }
            success(model)
            print("DATA: \(model)")
            
        }
    }
}
