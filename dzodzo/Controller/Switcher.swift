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
    var poscodeCheck: String?
    
    static func updateRootVC() {
        let rootVC: UIViewController?
        let loginStatus = UserDefaults.standard.bool(forKey: "isLogin")
        print("Trang thai Login: \(loginStatus)")
        
        if (loginStatus == true) {
            
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController")
            
        } else {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: UserDefaultKeys.usernameKey)
             defaults.removeObject(forKey: UserDefaultKeys.passwordKey)
             defaults.removeObject(forKey: UserDefaultKeys.tokenKey)
             defaults.removeObject(forKey: UserDefaultKeys.poscodeKey)
             defaults.removeObject(forKey: UserDefaultKeys.poscodeKey)
            
            defaults.synchronize()
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
        }
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
}
