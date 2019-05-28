//
//  ReportRevenueTax.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class ReportRevenueTaxAPI {
   
    static func getData(pstartdate: String, penddate: String, success: @escaping ([ReportRevenueTax])-> Void) {
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey),
            let pposgroupcode = UserDefaults.standard.string(forKey: UserDefaultKeys.posgroupKey),
            let pposcode = UserDefaults.standard.string(forKey: UserDefaultKeys.poscodeKey)
            else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "crud_search_report_tax_service"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "7"),
            URLQueryItem(name: "P1", value: pposgroupcode),
            URLQueryItem(name: "P2", value: pposcode),
            URLQueryItem(name: "P3", value: pstartdate),
            URLQueryItem(name: "P4", value: penddate),
            URLQueryItem(name: "P5", value: "20"),
            URLQueryItem(name: "P6", value: "1"),
            URLQueryItem(name: "P7", value: "0")
            ])
        
        guard let urlGetPos = componentsGetPost.url else {
            return
        }
        print("URL ReportRevenueTax: \(urlGetPos)")
        
        var urlRequest  = URLRequest(url: urlGetPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
        
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.isSuccess else {
                print("ERROR")
                return
            }
            
            guard let getposAPI = response.result.value as? [[String: Any]] else {return}
            
            var model = [ReportRevenueTax]()
            for dic in getposAPI {
                model.append(ReportRevenueTax(dic))
            }
            success(model)
            print("DATA: \(model)")
            
        }
    }
}
