//
//  ReportRevenuePayTypeAPI.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

import Alamofire

class ReportRevenuePayTypeAPI {
    static func getData(pstartdate: String, penddate: String, success: @escaping ([ReportRevenuePayType])-> Void) {
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey),
            let pposgroupcode = UserDefaults.standard.string(forKey: UserDefaultKeys.posgroupKey),
            let pposcode = UserDefaults.standard.string(forKey: UserDefaultKeys.poscodeKey)
            else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "search_revenue_payment_type"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "4"),
            URLQueryItem(name: "P1", value: pstartdate),
            URLQueryItem(name: "P2", value: penddate),
            URLQueryItem(name: "P3", value: pposgroupcode),
            URLQueryItem(name: "P4", value: pposcode)
            
            ])
        
        guard let urlGetPos = componentsGetPost.url else {
            return
        }
        print("URL ReportRevenuePayType with chart: \(urlGetPos)")
        
        var urlRequest  = URLRequest(url: urlGetPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
        
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.isSuccess else {
                print("ERROR")
                return
            }
            
            guard let getposAPI = response.result.value as? [[String: Any]] else {return}
            
            var model = [ReportRevenuePayType]()
            for dic in getposAPI {
                model.append(ReportRevenuePayType(dic))
            }
            success(model)
            print("DATA with chart: \(model)")
            
        }
    }
    
    
    
}
