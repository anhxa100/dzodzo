//
//  SearchPosCodeAPI.swift
//  dzodzo
//
//  Created by anhxa100 on 5/8/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class SearchPoscodeAPI {
    static func searchPosCode (pUserId: String, posgroupid: String, success: @escaping ([SearchPoscode]) -> Void){
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey) else {return}
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "crud_get_pos_for_posgroup_pos_service"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "2"),
            URLQueryItem(name: "P1", value: pUserId),
            URLQueryItem(name: "P2", value: posgroupid)
            ])
        
        guard let urlSearchPos = componentsGetPost.url else {
            return
        }
        print("URL SEARCHPOSTCODE/ GROUP: \(urlSearchPos)")
        
        var urlRequest  = URLRequest(url: urlSearchPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.isSuccess else {
                print("ERROR")
                return
            }
            
            guard let searchPosAPI = response.result.value as? [[String: Any]] else {return}
            
            var model = [SearchPoscode]()
            for dic in searchPosAPI {
                model.append(SearchPoscode(dic))
            }
            success(model)
        }
    }
}
