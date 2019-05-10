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
    static func searchPosCode (success: @escaping ([SearchPoscode]) -> Void, failure: @escaping ((String)->Void)){
        guard let token = UserDefaults.standard.string(forKey: UserDefaultKeys.tokenKey),
            let posgroupId = UserDefaults.standard.string(forKey: UserDefaultKeys.posgroupKey),
            let pUserId = UserDefaults.standard.string(forKey: UserDefaultKeys.usernameKey)
            
            else {return}
        
        let componentsGetPost = URLComponents(scheme: "https", host: "dzodzo.com.vn", path: "/a/api", queryItems: [
            URLQueryItem(name: "ServiceType", value: "query"),
            URLQueryItem(name: "Service", value: "crud_get_pos_for_posgroup_pos_service"),
            URLQueryItem(name: "Provider", value: "default"),
            URLQueryItem(name: "ParamSize", value: "2"),
            URLQueryItem(name: "P1", value: pUserId),
            URLQueryItem(name: "P2", value: posgroupId)
            ])
        
        guard let urlSearchPos = componentsGetPost.url else {
            return
        }
        print("URL SEARCHPOSTCODE/ GROUP: \(urlSearchPos)")
        
        var urlRequest  = URLRequest(url: urlSearchPos)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.allHTTPHeaderFields = ["Authorization": "\(token)"]
        
//        URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
//
//            guard let dataResponse = data,
//                error == nil else {
//                    print(error?.localizedDescription ?? "Response Error")
//                    return }
        
            
            //            do{
            //                //here dataResponse received from a network request
            //                let jsonResponse = try JSONSerialization.jsonObject(with:
            //                    dataResponse, options: [])
            //                print("DATASEARCHjsonResponse: \(jsonResponse)") //Response result
            //
            //                guard let jsonArray = jsonResponse as? [[String: Any]] else {
            //                    return
            //                }
            //                print(jsonArray)
            //
            //                for dic in jsonArray{
            //                    guard let title = dic["name"] as? String else { return }
            //                    print(title) //Output
            //
            //                }
            //
            //            } catch let parsingError {
            //                print("Error", parsingError)
            //            }
            //            }.resume()
            
            
            //MARK: Decodeable
            //            do {
            //                //here dataResponse received from a network request
            //                let decoder = JSONDecoder()
            //                let model = try decoder.decode([SearchPoscode].self, from:
            //                    dataResponse) //Decode JSON Response Data
            //                print(model.count) //Output - 1221
            //                success(model)
            //            } catch let parsingError {
            //                print("Error", parsingError)
            //            }
            //            }.resume()
            
            Alamofire.request(urlRequest).responseJSON{ response in
                guard response.result.isSuccess else {
                    print("ERROR")
                    return
                }
                
                guard let searchPosAPI = response.result.value as? [[String: Any]] else {return}
                print("searchPosAPI: \(searchPosAPI)")
                
                var model = [SearchPoscode]()
                for dic in searchPosAPI {
                    model.append(SearchPoscode(dic))
                }
                success(model)
                print("DATA SEARCH: \(model)")
            }
            
        }
    }
