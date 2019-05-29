//
//  ContainerViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 5/21/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class MenuReportRevenueProduct: MenuReportRevenueTotal {
    
    var rootVC: UIViewController?
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    var menuShowing = false
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuView.layer.opacity = 1
        menuView.layer.shadowRadius = 6
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func reportRevenueBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    @IBAction func reportRevenueProductBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "product")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    
    @IBAction func reportRevenuePaytypeBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "paytype")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    @IBAction func reportRevenueCategoryBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "category")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    
    @IBAction func reportRevenueDiscountBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "discount")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    @IBAction func reportRevenueTaxBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tax")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    
    @IBAction func reportRevenueDebtBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "debt")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    @IBAction func reportRevenueMaterialBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "materrialsItem")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    @IBAction func reportRevenueFeedbackBT(_ sender: Any) {
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "feedback")
        openMenu(menuShowing)
        print("Close menu")
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    
    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing) {
            leadingContraint.constant = -400
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }else {
            leadingContraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    @IBAction func signOut(_ sender: Any) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Bạn muốn đăng xuất?", message: "Điều này sẽ giúp bạn dễ dàng hơn trong việc chuyển đổi tài khoản hoặc chuyển tới các chuỗi cửa hàng khác", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            UserDefaults.standard.set(false, forKey: "isLogin")
            Switcher.updateRootVC()
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
