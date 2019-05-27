//
//  ReportRevenueProductViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 5/27/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import Charts
import CalendarDateRangePickerViewController

class ReportRevenueProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let calendar = Calendar.current
    let date = Date()
    let format = DateFormatter()
    @IBOutlet weak var tableView: UITableView!
    
    var revenueProductArray: [ReportRevenueProduct] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var opptionMenu: [UIButton]!
    @IBOutlet weak var dateChart: UILabel!
    @IBOutlet weak var chosseDay: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //Đặt tên nút mặc định
        chosseDay.setTitle("Hôm nay", for: .normal)
        
        // Xoá đường line tableview
        self.tableView.separatorStyle = .none
        
        //Call API
        ReportRevenueProductAPI.getRevenueTotal(pstartdate: "01/01/2019", penddate: "31/01/2019", success: {[weak self] data in
            self?.revenueProductArray = data
            print(data)
        })
    }
    
    enum DropdownOption: String {
        case today = "Hôm nay"
        case thisWeek = "Tuần này"
        case thisMonth = "Tháng này"
        case thisYear = "Năm nay"
        case option = "Tuỳ chọn"
    }

    @IBAction func toDayDropDownMenu(_ sender: Any) {
        buttonHidden()
    }
    
    @IBAction func dropdownMenu(_ sender: UIButton) {
        guard let title = sender.currentTitle, let nameButton = DropdownOption(rawValue: title) else {return}
        chosseDay.setTitle(title, for: UIControl.State.normal)
        switch nameButton {
        case .today:
            print("Hom nay")
//            thisDate()
            buttonHidden()
        case .thisWeek:
            print("Tuan nay")
//            thisWeek()
            buttonHidden()
        case .thisMonth:
            print("Thang nay")
//            thisMonth()
            buttonHidden()
        case .thisYear:
            print("Nam nay")
//            thisYear()
            buttonHidden()
        case .option:
            print("Tuy chon")
//            optionDay()
            buttonHidden()
        }
        
        print("TITLE: \(title)")
    }
    
    // Ẩn - hiện menu chọn thời gian
    func buttonHidden() {
        opptionMenu.forEach{(button) in
            UIView.animate(withDuration: 0.2, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    //Ngày kế tiếp
    @IBAction func nextDay(_ sender: Any) {
        print("Next day")
    }
    //Ngày trước
    @IBAction func preDay(_ sender: Any) {
        print("Pre day")
    }
    
    
    //MARK: Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        cell.itemnameLB.text = revenueProductArray[indexPath.row].itemname
        cell.quantityLB.text = "\(revenueProductArray[indexPath.row].quantity) sản phẩm"
        cell.totalamountLB.text = "Tổng doanh thu: \(revenueProductArray[indexPath.row].totalamount)đ"
        cell.totoaldiscountLB.text = "Tổng giảm giá: \(revenueProductArray[indexPath.row].totaldiscount)đ"
        return cell 
    }
    
}
