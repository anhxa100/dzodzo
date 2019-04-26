//
//  AccountAPI.swift
//  dzodzo
//
//  Created by anhxa100 on 4/22/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CryptoSwift

class AccountAPI {
    
    
    static func login(with input : Account.DataAfterValiDate, result: @escaping ((Account)-> ())) {
        let defaultError = Account(message: "API error... ", _token: nil)
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let components = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "value"),
            URLQueryItem(name: "Service", value: "login_service_mobile"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "3"),
            URLQueryItem(name: "P1", value: input.username),
            URLQueryItem(name: "P2", value: input.pass.lowercased().md5()),
            URLQueryItem(name: "P3", value: uuid)
            ])
        
        guard let url = components.url else {
            result(defaultError)
            return
        }
        print("URL: \(url)")
        
        
        // Request API
        Alamofire.request(url, method: .get).responseString{response in
            switch response.result{
            case .success( _):
                let data = response.result.value as? String
                let tokenAPI = data?.trimmingCharacters(in: .init(charactersIn: "\n")) // Loại bỏ \n trong TOKEN trả về từ API
                print("TOKEN LOGIN \(tokenAPI)")
                result(Account(message: "done", _token: tokenAPI))
                
            case .failure(let error):
                print("error \(error)")
            }
        }
        
        
        
//        Alamofire.request(urlRequest, method: .get)
    }
    
    

}



extension URLComponents {
    init(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) {
        self.init()
        //        let queryItem = URLQueryItem(name: "q", value: "Formula One")
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

