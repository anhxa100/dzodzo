//
//  Connectivity.swift
//  dzodzo
//
//  Created by anhxa100 on 6/10/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
