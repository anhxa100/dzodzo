//
//  TotalDashboardTableViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 5/6/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import Charts

class TotalDashboardTableViewController: UITableViewController, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var barChartView: BarChartView!
    var revenueTotal: [ReportRevenueTotal] = []
    
    @IBOutlet weak var SlideDashboard: UICollectionView!
    @IBOutlet var opptionMenu: [UIButton]!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReportRevenueTotalAPI.getRevenueTotal(success: {[weak self] dataTotal in
            self?.revenueTotal = dataTotal
        })
        barChartView.noDataText = "Không hiển thị dữ liệu, vui lòng kiểm tra lại"
        
    }
    
    
    // MARK: - Table view data source
    @IBAction func menuDashBoard(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    
    // Menu tuỳ chọn trên màn hình Chart
    @IBAction func toDayDropDownMenu(_ sender: Any) {
        opptionMenu.forEach{(button) in
            UIView.animate(withDuration: 0.2, animations: {
                button.isHidden = !button.isHidden
            })
            
        }
        
    }
    
    //Tuỳ chọn tgian
    @IBAction func dropdownMenu(_ sender: UIButton) {
        
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
