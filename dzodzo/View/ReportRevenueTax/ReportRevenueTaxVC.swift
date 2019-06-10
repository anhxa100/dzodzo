//
//  ReportRevenueTaxVC.swift
//  dzodzo
//
//  Created by anhxa100 on 5/28/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import CalendarDateRangePickerViewController

class ReportRevenueTaxVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    let calendar = Calendar.current
    var date = Date()
    let format = DateFormatter()
    @IBOutlet weak var tableView: UITableView!
    
    var taxArray: [ReportRevenueTax] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var opptionMenu: [UIButton]!
    @IBOutlet weak var dateChart: UILabel!
    @IBOutlet weak var chosseDay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController()?.rearViewRevealWidth = 400
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //Đặt tên nút mặc định
        chosseDay.setTitle("Hôm nay", for: .normal)
        
        // Xoá đường line tableview
//        self.tableView.separatorStyle = .none
        self.tableView.separatorColor = UIColor.clear
        
        //Đặt tên nút mặc định
        //Định dạng ngày giờ hiển thị
        format.dateFormat = "dd/MM/yyyy"
        thisDate()
        chosseDay.setTitle("Hôm nay", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }
        
        if Connectivity.isConnectedToInternet() == false {
            let alertController = UIAlertController(title: "Không có kết nối internet", message: "Vui lòng kiểm tra kết nối wifi/3G", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            print("No have internet")
        }
        
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
    func nextDay(){
        let myDate = format.date(from: dateChart.text!)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = format.string(from: tomorrow!)
        dateChart.text = somedateString
        ReportRevenueTaxAPI.getData(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.taxArray = dayData
        })
        
    }
    
    //Ngày hôm trước
    func preDay(){
        
        let myDate = format.date(from: dateChart.text!)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        
        let somedateString = format.string(from: yesterday!)
        dateChart.text = somedateString
        ReportRevenueTaxAPI.getData(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.taxArray = dayData
        })
    }
    
    //Tuần kế tiếp
    func nextWeek(){
        
        let today = calendar.startOfDay(for: date)
        let nextweek = Calendar.current.date(byAdding: .day, value: 7, to: date)!
        date = nextweek
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = ((weekdays.lowerBound+1) ... weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        
        guard let _firstDay = days.first else {return}
        guard let _lastDay = days.last else {return}
        
        let nextWeekFirstDay = Calendar.current.date(byAdding: .day, value: 7, to: _firstDay)!
        let nextWeekLastDay = Calendar.current.date(byAdding: .day, value: 7, to: _lastDay)!
        
        let firstDay = format.string(from: nextWeekFirstDay)
        let lastDay = format.string(from: nextWeekLastDay)
        
        dateChart.text = "\(firstDay) - \(lastDay)"
        
        ReportRevenueTaxAPI.getData(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.taxArray = weekData
        })
    }
    
    //Func tuần trước
    func preWeek(){
        
        let today = calendar.startOfDay(for: date)
        let preweek = Calendar.current.date(byAdding: .day, value: -7, to: date)!
        date = preweek
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = ((weekdays.lowerBound+1) ... weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        
        guard let _firstDay = days.first else {return}
        guard let _lastDay = days.last else {return}
        
        let nextWeekFirstDay = Calendar.current.date(byAdding: .day, value: -7, to: _firstDay)!
        let nextWeekLastDay = Calendar.current.date(byAdding: .day, value: -7, to: _lastDay)!
        
        let firstDay = format.string(from: nextWeekFirstDay)
        let lastDay = format.string(from: nextWeekLastDay)
        
        dateChart.text = "\(firstDay) - \(lastDay)"
        
        ReportRevenueTaxAPI.getData(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.taxArray = weekData
        })
    }
    
    // MARK: Fuc tháng kế tiếp
    func nextMonth() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)!
        date = nextMonth
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let startDateOfMonth = format.string(from: startOfMonth)
        print(startDateOfMonth)
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)!
        let endDateOfMonth = format.string(from: endOfMonth)
        print(endDateOfMonth)
        
        dateChart.text = "Tháng \(month) năm \(year)"
        
        ReportRevenueTaxAPI.getData(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.taxArray = monthData
        })
    }
    
    // Tháng trước
    func preMonth()  {
        
        let preMonth = Calendar.current.date(byAdding: .month, value: -1, to: date)!
        date = preMonth
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let startDateOfMonth = format.string(from: startOfMonth)
        print(startDateOfMonth)
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)!
        let endDateOfMonth = format.string(from: endOfMonth)
        print(endDateOfMonth)
        
        dateChart.text = "Tháng \(month) năm \(year)"
        
        ReportRevenueTaxAPI.getData(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.taxArray = monthData
        })
    }
    
    
    // Năm sau
    func nextYear() {
        
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: date)!
        date = nextYear
        var components = Calendar.current.dateComponents([.year], from: date)
        let year = calendar.component(.year, from: nextYear)
        if let startDate = Calendar.current.date(from: components) {
            components.year = 1
            components.day = -1
            let lastDate = Calendar.current.date(byAdding: components, to: startDate)!
            let startDateOfYear = format.string(from: startDate)
            let lastDateOfYear = format.string(from: lastDate)
            
            dateChart.text = "Năm \(year)"
            
            print(startDateOfYear)
            print(lastDateOfYear)
            
            ReportRevenueTaxAPI.getData(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.taxArray = yearData
            })
            
            
        }
    }
    
    // Năm trước
    func preYear() {
        
        let preYear = Calendar.current.date(byAdding: .year, value: -1, to: date)!
        date = preYear
        var components = Calendar.current.dateComponents([.year], from: date)
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
            
            ReportRevenueTaxAPI.getData(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.taxArray = yearData
            })
        }
    }
    
    //Lấy ngày hiện tại
    func thisDate() {
        dateChart.text = format.string(from: Date())
        ReportRevenueTaxAPI.getData(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.taxArray = dayData
        })
        date = Date()
    }
    //MARK: Lấy data ngày trong tuần
    func thisWeek() {
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = ((weekdays.lowerBound+1) ... weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        
        guard let _firstDay = days.first else {return}
        guard let _lastDay = days.last else {return}
        
        print("NGÀY TRONG TUẦN: \(days)")
        print("SỐ NGÀY TRONG TUẦN: \(days.endIndex)")
        let firstDay = format.string(from: _firstDay)
        let lastDay = format.string(from: _lastDay)
        print(firstDay)
        print(lastDay)
        
        dateChart.text = "\(firstDay) - \(lastDay)"
        
        ReportRevenueTaxAPI.getData(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.taxArray = weekData
        })
        date = Date()
    }
    
    
    //MARK: Lấy data theo tháng trong năm
    func thisMonth () {
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())
        
        let components = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: components)!
        let startDateOfMonth = format.string(from: startOfMonth)
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)!
        let endDateOfMonth = format.string(from: endOfMonth)
        
        dateChart.text = "Tháng \(month) năm \(year)"
        
        ReportRevenueTaxAPI.getData(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.taxArray = monthData
        })
        date = Date()
    }
    
    //MARK: Lấy data theo năm
    func thisYear() {
        var components = Calendar.current.dateComponents([.year], from: Date())
        let year = calendar.component(.year, from: Date())
        if let startDate = Calendar.current.date(from: components) {
            components.year = 1
            components.day = -1
            let lastDate = Calendar.current.date(byAdding: components, to: startDate)!
            let startDateOfYear = format.string(from: startDate)
            let lastDateOfYear = format.string(from: lastDate)
            dateChart.text = "Năm \(year)"
            
            print(startDateOfYear)
            print(lastDateOfYear)
            
            ReportRevenueTaxAPI.getData(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.taxArray = yearData
            })
        }
        date = Date()
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
        date = Date()
    }
    
    //Ngày kế tiếp
    @IBAction func nextDay(_ sender: Any) {
        if chosseDay.currentTitle == "Hôm nay" {
            nextDay()
            print("hehe1")
        }
        if chosseDay.currentTitle == "Tuần này" {
            nextWeek()
            print("hehe2")
        }
        if chosseDay.currentTitle == "Tháng này" {
            nextMonth()
            print("hehe3")
        }
        if chosseDay.currentTitle == "Năm nay" {
            nextYear()
            print("hehe4")
        }
        if chosseDay.currentTitle == "Tuỳ chọn" {
            print("hehe5")
        }
        print("Next day")
    }
    //Ngày trước
    @IBAction func preDay(_ sender: Any) {
        if chosseDay.currentTitle == "Hôm nay" {
            preDay()
            print("hehe1")
        }
        if chosseDay.currentTitle == "Tuần này" {
            preWeek()
            print("hehe2")
        }
        if chosseDay.currentTitle == "Tháng này" {
            preMonth()
            print("hehe3")
        }
        if chosseDay.currentTitle == "Năm nay" {
            preYear()
            print("hehe4")
        }
        if chosseDay.currentTitle == "Tuỳ chọn" {
            print("hehe5")
        }
        print("Pre day")
    }
    
    
    //MARK: Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if taxArray.count > 0{
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "Không có dữ liệu trong thời gian này"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaxCell
        
        cell.taxnameLB.text = taxArray[indexPath.row].taxname
        cell.totaltaxLB.text = "Tổng thuế: \(taxArray[indexPath.row].totaltax) ₫"
        
        return cell
    }
    
}

extension ReportRevenueTaxVC : CalendarDateRangePickerViewControllerDelegate {
    
    func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // Chọn ngày theo range
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        let startDay = format.string(from: startDate)
        let endDay = format.string(from: endDate)
        
        dateChart.text = "\(startDay) - \(endDay) "
        
        ReportRevenueTaxAPI.getData(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.taxArray = chooseData
        })
        
    }
    
}
