//
//  TotalDashboardTableViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 5/6/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import Charts
import CalendarDateRangePickerViewController

class TotalDashboardTableViewController: UITableViewController, UICollectionViewDataSource {
    
    
    var refresher : UIRefreshControl!
    let calendar = Calendar.current
    let date = Date()
    let format = DateFormatter()
    weak var axisFormatDelegate: IAxisValueFormatter?
    var revenueTotal: [ReportRevenueTotal] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var SlideDashboard: UICollectionView!
    @IBOutlet var opptionMenu: [UIButton]!
    @IBOutlet weak var dateChart: UILabel!
    @IBOutlet weak var chosseDay: UIButton!
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.dateFormat = "dd/MM/yyyy"
        thisDate()

        
        print("dateChart \(dateChart.text!)")
        //Pull to Refesh
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        //        refresher.attributedTitle = NSAttributedString(string : "Refesh data")// add Tittle for pull icon
        refresher.addTarget(self, action: #selector(addArr), for: .valueChanged)
        refresher.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        
        // Report when no have data or network error
        barChartView.noDataText = "Không có dữ liệu hiển thị trong thời gian  "
        
        //Đặt tên nút mặc định
        chosseDay.setTitle("Hôm nay", for: .normal)
    }
    //MARK: Chart
//    func updateChartWithData() {
//        var dataEntries: [BarChartDataEntry] = []
//        let totalAmount = getVisitorCountsFromeDatabase()
//        for i in 0..<totalAmount.count {
//            let timeIntervalForDate: TimeInterval = totalAmount[i].date.timeIntervalSince1970
//            let dataEntry = BarChartDataEntry(x: Double(timeIntervalForDate), y: Double(totalAmount[i].totalamount))
//            dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Hoang Label")
//        let chartData = BarChartData(dataSet: chartDataSet)
//
//
//        barChartView.data = chartData
//
//        let xaxis = barChartView.xAxis
//        xaxis.valueFormatter = axisFormatDelegate
//    }
    
//    func getVisitorCountsFromeDatabase() -> Results<DataRealm> {
//        do {
//            let realm = try Realm()
//            return realm.objects(DataRealm.self)
//        }catch let error as NSError {
//            fatalError(error.localizedDescription)
//        }
//    }
    
    @objc func addArr() {
        refresher.beginRefreshing()
        tableView.reloadData()
        refresher.endRefreshing() //End of refesh
    }
    
    //Ngày kế tiếp
    @IBAction func nextDay(_ sender: Any) {
        print("Next day")
    }
    //Ngày trước
    @IBAction func preDay(_ sender: Any) {
        print("Pre day")
    }
    
    // MARK: - Table view data source
    @IBAction func menuDashBoard(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    
    // Menu tuỳ chọn trên màn hình Chart
    @IBAction func toDayDropDownMenu(_ sender: Any) {
        buttonHidden()
    }
    
    enum DropdownOption: String {
        case today = "Hôm nay"
        case thisWeek = "Tuần này"
        case thisMonth = "Tháng này"
        case thisYear = "Năm nay"
        case option = "Tuỳ chọn"
    }
    
    func buttonHidden() {
        opptionMenu.forEach{(button) in
            UIView.animate(withDuration: 0.2, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    //Tuỳ chọn tgian
    @IBAction func dropdownMenu(_ sender: UIButton) {
        guard let title = sender.currentTitle, let nameButton = DropdownOption(rawValue: title) else {return}
        chosseDay.setTitle(title, for: UIControl.State.normal)
        switch nameButton {
        case .today:
            print("Hom nay")
            thisDate()
            buttonHidden()
        case .thisWeek:
            print("Tuan nay")
            thisWeek()
            buttonHidden()
        case .thisMonth:
            print("Thang nay")
            thisMonth()
            buttonHidden()
        case .thisYear:
            print("Nam nay")
            thisYear()
            buttonHidden()
        case .option:
            print("Tuy chon")
            optionDay()
            buttonHidden()
        }
        
        print("TITLE: \(title)")
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
    
    //Lấy ngày hiện tại
    func thisDate() {
        dateChart.text = format.string(from: date)
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotal = dayData
        })
    }
    
    //MARK: Lấy data   ngày trong tuần
    func thisWeek() {
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = ((weekdays.lowerBound+1) ... weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        
        guard let _firstDay = days.first else {return}
        guard let _lastDay = days.last else {return}
        
        format.dateFormat = "dd/MM/yyyy"
        print("NGÀY TRONG TUẦN: \(days) ")
        print("SỐ NGÀY TRONG TUẦN: \(days.endIndex)")
        let firstDay = format.string(from: _firstDay)
        let lastDay = format.string(from: _lastDay)
        print(firstDay)
        print(lastDay)
        
        dateChart.text = "\(firstDay) - \(lastDay)"
        
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotal = weekData
        })
    }
    
    //MARK: Lấy data theo tháng trong năm
    func thisMonth () {
        let month = calendar.component(.month, from: date)
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let startDateOfMonth = format.string(from: startOfMonth)
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)!
        let endDateOfMonth = format.string(from: endOfMonth)
        
        dateChart.text = "Tháng \(month)"
        
        print(startDateOfMonth)
        print(endDateOfMonth)
        
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotal = monthData
        })
    }
    
    //MARK: Lấy data theo năm
    func thisYear() {
        var components = Calendar.current.dateComponents([.year], from: Date())
        let year = calendar.component(.year, from: date)
        if let startDate = Calendar.current.date(from: components) {
            components.year = 1
            components.day = -1
            let lastDate = Calendar.current.date(byAdding: components, to: startDate)!
            let startDateOfYear = format.string(from: startDate)
            let lastDateOfYear = format.string(from: lastDate)
            dateChart.text = "Năm \(year)"
            
            print(startDateOfYear)
            print(lastDateOfYear)
            
            ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotal = yearData
            })

        }
    }
    
    //MARK: Lấy data theo ngày tự chọn
    func optionDay() {
       
        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self as CalendarDateRangePickerViewControllerDelegate
        dateRangePickerViewController.minimumDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())
        dateRangePickerViewController.maximumDate = Date()
        dateRangePickerViewController.selectedStartDate = Date()
        dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}

extension TotalDashboardTableViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

extension TotalDashboardTableViewController : CalendarDateRangePickerViewControllerDelegate {

    func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.navigationController?.dismiss(animated: true, completion: nil)
        let startDay = format.string(from: startDate)
        let endDay = format.string(from: endDate)
        
        dateChart.text = "\(startDay) - \(endDay) "
        
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.revenueTotal = chooseData
        })
        
    }
    
}
