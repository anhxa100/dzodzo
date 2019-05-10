//
//  AppDelegate.swift
//  dzodzo
//
//  Created by anhxa100 on 4/16/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Change color apps
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.colorFormHex(hex: 0x52535A )
        navigationBarAppearace.barTintColor = UIColor.colorFormHex(hex: 0x68B8F6)
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorFormHex(hex: 0x52535A)]
        
        //Key
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 8
        IQKeyboardManager.shared.previousNextDisplayMode = IQPreviousNextDisplayMode.Default
        IQKeyboardManager.shared.enableDebugging = true
        
        // Override point for customization after application launch.
        
        if UserDefaults.standard.object(forKey: UserDefaultKeys.tokenKey) != nil,
        UserDefaults.standard.object(forKey: UserDefaultKeys.passwordKey) != nil,
            UserDefaults.standard.object(forKey: UserDefaultKeys.usernameKey) != nil,
            UserDefaults.standard.object(forKey: UserDefaultKeys.posgroupKey) != nil {
            // User đã login được và set lại entrypoint vào màn home
        }
        Switcher.updateRootVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//extension UIColor {
//    static func colorFormHex(hex: UInt32) -> UIColor{
//        let div = CGFloat (255)
//        let red = CGFloat ((hex & 0xFF0000) >> 16) / div
//        let green = CGFloat((hex & 0x00FF00) >> 8) / div
//        let blue  = CGFloat(hex & 0x0000FF)  / div
//        return UIColor(red: red, green: green, blue: blue, alpha:  1)
//    }
//}
