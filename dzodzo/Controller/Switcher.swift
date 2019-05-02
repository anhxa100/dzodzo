//
//  Switcher.swift
//  dzodzo
//
//  Created by anhxa100 on 4/22/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import  UIKit

class Switcher {
    
    static func updateRootVC() {
        let rootVC: UIViewController?
        let loginStatus = UserDefaults.standard.bool(forKey: "isLogin")
        print("Trang thau Login: \(loginStatus)")
        
        
        if (loginStatus == true) {
            
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "container")
            
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
        }
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
}
