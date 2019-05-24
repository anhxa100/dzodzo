//
//  MenuDashBoardVC.swift
//  dzodzo
//
//  Created by anhxa100 on 4/18/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class MenuDashBoardVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        menuView.layer.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickGetReportRevenueTotalTable(_ sender: Any) {
        print("Tổng doanh thu")
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTotal")
    }
    
    @IBAction func onClick2(_ sender: Any) {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "product")
        print("Đồ thị doanh thu theo sản phẩm")
    }
    @IBAction func onClick3(_ sender: Any) {
        print("Doanh thu theo danh mục")
    }
    @IBAction func onClick4(_ sender: Any) {
    }
    @IBAction func onClick5(_ sender: Any) {
    }
    
    @IBAction func onClick6(_ sender: Any) {
    }
    @IBAction func onClick7(_ sender: Any) {
    }
    @IBAction func onClick8(_ sender: Any) {
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
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
}
