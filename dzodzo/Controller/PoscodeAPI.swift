//
//  PoscodeAPI.swift
//  dzodzo
//
//  Created by anhxa100 on 4/26/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import  Alamofire
import UIKit

class PosCodeAPI {
    static func getPoscode(success: @escaping ([CheckPoscode]) -> ()) {
        
        guard let usename = UserDefaults.standard.string(forKey: UserDefaultKeys.usernameKey),
            let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey) else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "mobile_search_staff_info_service"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "1"),
            URLQueryItem(name: "P1", value: usename)
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
            
            var arr : [CheckPoscode] = []
            
            guard let poscode = getposAPI[0]["poscode"] as? String else {return}
            guard let posgroupcode = getposAPI[0]["posgroupcode"] as? String else {return}
            print("TEST POS: \(poscode)")
            print("TES POSGROUP: \(posgroupcode)")
            print( "GETPOSTCODE/ GROUP API: \(getposAPI)")
            // add phan tu trong mang getposAPI vao mang arr de su dung
            
            }
        }
    }
    

