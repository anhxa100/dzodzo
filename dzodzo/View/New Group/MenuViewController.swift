//
//  MenuViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 5/29/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuNameArr: Array = [String]()
    var iconImage:Array = [UIImage]()
    var infoArr:[CheckPoscode] = [] 
    @IBOutlet weak var nameStaffLB: UILabel!
    @IBOutlet weak var positionLB: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Xoá đường line tableview
        self.tableView.separatorStyle = .none
        
        menuNameArr = ["Tổng hợp doanh thu", "Doanh thu theo sản phẩm", "Doanh thu theo danh mục", "Doanh thu theo loại thanh toán", "Thống kê khuyến mại", "Thống kê thuế", "Thống kê nợ", "Nguyên liệu theo mặt hàng", "Đánh giá của khách hàng", "Đăng xuất" ]
        iconImage = [UIImage(named: "icons8-cash")!, UIImage(named: "icons8-cheap_2_1")!, UIImage(named: "icons8-coin_in_hand")!, UIImage(named: "icons8-currency_exchange")!, UIImage(named: "icons8-dollar_sign_7")!, UIImage(named: "icons8-expensive_2")!, UIImage(named: "icons8-hkd")!, UIImage(named: "icons8-money_bag")!, UIImage(named: "icons8-split_payment_copy_2")!, UIImage(named: "icons8-1_shutdown")! ]
        
        PosCodeAPI.getPoscode(success: {[weak self] data in
            self?.infoArr = data
            self!.nameStaffLB.text = self?.infoArr[0].nameStaff
            self!.positionLB.text = "POS: \(self!.infoArr[0].position)"
        })
        // Do any additional setup after loading the view.
    }
    
//TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        cell.menuLB.text = menuNameArr[indexPath.row]
        cell.iconMenu.image = iconImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController: SWRevealViewController = self.revealViewController()
        let cell: MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        
        //
        if cell.menuLB.text!  == "Tổng hợp doanh thu" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "total") as! TotalDashboardTableViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Doanh thu theo sản phẩm" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "product") as! ReportRevenueProductViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Doanh thu theo danh mục" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "category") as! ReportRevenueCategoryVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Doanh thu theo loại thanh toán" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "paytype") as! ReportRevenuePayTypeVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Thống kê khuyến mại" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "discount") as! ReportRevenueDiscountVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Thống kê thuế" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "tax") as! ReportRevenueTaxVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Thống kê nợ" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "debt") as! ReportRevenueCustomerDebtVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Nguyên liệu theo mặt hàng" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "material") as! ReportRevenueMaterialsItemDailyVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Đánh giá của khách hàng" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "feedback") as! ReportRevenueFeedbackVC
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        //
        if cell.menuLB.text!  == "Đăng xuất" {
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

}
