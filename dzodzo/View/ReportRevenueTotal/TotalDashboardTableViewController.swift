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

class TotalDashboardTableViewController: UITableViewController {
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    var shouldHideData: Bool = false
    var refresher : UIRefreshControl!
    let calendar = Calendar.current
    var date = Date()
    let format = DateFormatter()
    let currencyFormatter = NumberFormatter()
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    var revenueTotalArray: [ReportRevenueTotal] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var revenueTotalWithoutchart: [ReportRevenueTotal] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    @IBOutlet weak var chartView: BarChartView!
    
    @IBOutlet var opptionMenu: [UIButton]!
    @IBOutlet weak var dateChart: UILabel!
    @IBOutlet weak var chosseDay: UIButton!
    
    //Label hiển thị data không qua chart
    @IBOutlet weak var totalamountLB: UILabel!
    @IBOutlet weak var paybackamountLB: UILabel!
    @IBOutlet weak var totaldiscountLB: UILabel!
    @IBOutlet weak var taxamountLB: UILabel!
    
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController()?.rearViewRevealWidth = 400
        
        // quy đổi tiền
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "vi_VN")
        // Xoá đường line tableview
        self.tableView.separatorStyle = .none
        
        //Định dạng ngày giờ hiển thị
        format.dateFormat = "dd/MM/yyyy"
        
        thisDate()
        print("dateChart \(dateChart.text!)")
        
        
        //Pull to Refesh
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        //        refresher.attributedTitle = NSAttributedString(string : "Refesh data")// add Tittle for pull icon
        refresher.addTarget(self, action: #selector(refesh), for: .valueChanged)
        refresher.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        
        // Report when network error
        chartView.noDataText = "Không có dữ liệu hiển thị, vui lòng kết nối mạng"
        
        //Đặt tên nút mặc định
        chosseDay.setTitle("Hôm nay", for: .normal)
        
        viewChartData()
        
    }
    // Hiển thị thanh cuộn khi scroll tableView
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
    
    
    
    //Hiển thị biểu đồ
    func viewChartData() {
        // Tuỳ chỉnh chữ hiện thị thi bấm vào
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1), font: .systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        //Tuỳ chỉnh hiện thị bảng
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = IntAxisValueFormatter()
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.valueFormatter = LargeValueFormatter()
        leftAxis.spaceTop = 0.35
        leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
    }
    
    func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
    }
    
    // Lấy data để hiển thị
    func viewData() {
        let groupSpace = 0.08
        let barSpace = 0.03
        let barWidth = 0.2
        var totalDayChart: [String] = []
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
        
        //lọc dữ liệu hiển thị, lấy x,y
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            totalDayChart.append(self.revenueTotalArray[i].date)
            print("DATA DAY: \(totalDayChart)")
            return BarChartDataEntry(x: Double(i), y: Double(self.revenueTotalArray[i].totalamount) ?? 0.0 )
        }
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(self.revenueTotalArray[i].totaldiscount) ?? 0.0)
        }
        let block3: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(self.revenueTotalArray[i].paybackamount) ?? 0.0)
        }
        let block4: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(self.revenueTotalArray[i].taxamount) ?? 0.0)
        }
        
        
        let yVals1: [BarChartDataEntry] = (0..<revenueTotalArray.count).map(block1)
        let yVals2: [BarChartDataEntry] = (0..<revenueTotalArray.count).map(block2)
        let yVals3: [BarChartDataEntry] = (0..<revenueTotalArray.count).map(block3)
        let yVals4: [BarChartDataEntry] = (0..<revenueTotalArray.count).map(block4)
        
        
        print("yVals1: \(yVals1)")
        print("yVals2: \(yVals2)")
        print("DATADAY: \(totalDayChart)")
        
        //Thiết lập tên, đặt màu cho cột
        let set1 = BarChartDataSet(entries: yVals1, label: "Tổng doanh thu")
        set1.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        let set2 = BarChartDataSet(entries: yVals2, label: "Tổng giảm giá")
        set2.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        let set3 = BarChartDataSet(entries: yVals3, label: "Tổng hoàn tiền")
        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        let set4 = BarChartDataSet(entries: yVals4, label: "Tổng thuế")
        set4.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: totalDayChart)
        chartView.xAxis.setLabelCount(totalDayChart.count, force: false)
        
        
        let data = BarChartData(dataSets: [set1, set2, set3, set4])
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setValueFormatter(LargeValueFormatter())
        
        
        // specify the width each bar should have
        data.barWidth = barWidth
        
        // restrict the x-axis range
        chartView.xAxis.axisMinimum = Double(0)
        
        /// groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        chartView.xAxis.axisMaximum = Double(0) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(revenueTotalArray.count)
        
        data.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        
        chartView.data = data
        chartView.animate(xAxisDuration: 0.8, yAxisDuration: 0.8)
        
        chartView.setNeedsDisplay()
    }
    
    //func refresh
    @objc func refesh() {
        refresher.beginRefreshing()
        tableView.reloadData()
        refresher.endRefreshing() //End of refesh
    }
    
    //Ngày kế tiếp
    func nextDay(){
        let myDate = format.date(from: dateChart.text!)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = format.string(from: tomorrow!)
        dateChart.text = somedateString
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalArray = dayData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalWithoutchart = dayData
            self?.getDataWithoutChart()
        })
        print(" \(somedateString)")
        
    }
    
    //Ngày hôm trước
    func preDay(){
        
        let myDate = format.date(from: dateChart.text!)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: myDate)
        
        let somedateString = format.string(from: yesterday!)
        dateChart.text = somedateString
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalArray = dayData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalWithoutchart = dayData
            self?.getDataWithoutChart()
        })
        print(" \(somedateString)")
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalArray = weekData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalWithoutchart = weekData
            self?.getDataWithoutChart()
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalArray = weekData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalWithoutchart = weekData
            self?.getDataWithoutChart()
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalArray = monthData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalWithoutchart = monthData
            self?.getDataWithoutChart()
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalArray = monthData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalWithoutchart = monthData
            self?.getDataWithoutChart()
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
            
            ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalArray = yearData
                self?.viewData()
            })
            
            ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalWithoutchart = yearData
                self?.getDataWithoutChart()
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
            
            ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalArray = yearData
                self?.viewData()
            })
            
            ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalWithoutchart = yearData
                self?.getDataWithoutChart()
            })
            
        }
    }
    
    
    //Ngày kế tiếp
    @IBAction func nextDay(_ sender: UIButton) {
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
    @IBAction func preDay(_ sender: UIButton) {
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
    
    // Menu tuỳ chọn trên màn hình Chart
    @IBAction func toDayDropDownMenu(_ sender: UIButton) {
        buttonHidden()
    }
    
    
    enum DropdownOption: String {
        case today = "Hôm nay"
        case thisWeek = "Tuần này"
        case thisMonth = "Tháng này"
        case thisYear = "Năm nay"
        case option = "Tuỳ chọn"
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
    
    //Lấy ngày hiện tại
    func thisDate() {
        dateChart.text = format.string(from: Date())
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalArray = dayData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueTotalWithoutchart = dayData
            self?.getDataWithoutChart()
        })
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalArray = weekData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueTotalWithoutchart = weekData
            self?.getDataWithoutChart()
        })
        
        //reset date
        date = Date()
    }
    
    //MARK: Lấy data theo tháng trong năm
    func thisMonth() {
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
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalArray = monthData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueTotalWithoutchart = monthData
            self?.getDataWithoutChart()
        })
        //reset date
        date = Date()
    }
    
    //MARK: Lấy data theo năm
    func thisYear() {
        let year = calendar.component(.year, from: Date())
        var components = Calendar.current.dateComponents([.year], from: Date())
        if let startDate = Calendar.current.date(from: components) {
            components.year = 1
            components.day = -1
            let lastDate = Calendar.current.date(byAdding: components, to: startDate)!
            let startDateOfYear = format.string(from: startDate)
            let lastDateOfYear = format.string(from: lastDate)
            
            
            dateChart.text = "Năm \(year)"
            
            
            print(startDateOfYear)
            print(lastDateOfYear)
            
            ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalArray = yearData
                self?.viewData()
            })
            
            ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueTotalWithoutchart = yearData
                self?.getDataWithoutChart()
            })
            
        }
        
        //reset date
        date = Date()
    }
    
    //MARK: Lấy data theo ngày tự chọn
    func optionDay() {
        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self as CalendarDateRangePickerViewControllerDelegate
        dateRangePickerViewController.minimumDate = Calendar.current.date(byAdding: .year, value: -2, to: Date())
        dateRangePickerViewController.maximumDate = Date()
        dateRangePickerViewController.selectedStartDate = Date()
        dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 10, to: date)
        
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    //Hiển thị theo label
    func getDataWithoutChart() {
        if self.revenueTotalWithoutchart.count == 0 {
            self.totalamountLB.text = "0₫"
            self.paybackamountLB.text = "0₫"
            self.totaldiscountLB.text = "0₫"
            self.taxamountLB.text = "0₫"
            
        }else{
            
            self.totalamountLB.text = "\(self.revenueTotalWithoutchart[0].totalamount) ₫"
            self.paybackamountLB.text = "\(self.revenueTotalWithoutchart[0].paybackamount) ₫"
            self.totaldiscountLB.text = "\(self.revenueTotalWithoutchart[0].totaldiscount) ₫"
            self.taxamountLB.text = "\(self.revenueTotalWithoutchart[0].taxamount) ₫"
            
        }
    }
    
    
}

extension TotalDashboardTableViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return format.string(from: Date(timeIntervalSince1970: value))
    }
}

extension TotalDashboardTableViewController : CalendarDateRangePickerViewControllerDelegate {
    
    func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // Chọn ngày theo range
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        let startDay = format.string(from: startDate)
        let endDay = format.string(from: endDate)
        
        dateChart.text = "\(startDay) - \(endDay) "
        
        ReportRevenueTotalAPI.getRevenueTotalWithChart(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.revenueTotalArray = chooseData
            self?.viewData()
        })
        ReportRevenueTotalAPI.getRevenueTotal(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.revenueTotalWithoutchart = chooseData
            self?.getDataWithoutChart()
        })
    }
    
}

