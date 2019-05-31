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

class ReportRevenueProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChartViewDelegate {
    
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    var shouldHideData: Bool = false
    let calendar = Calendar.current
    let date = Date()
    let format = DateFormatter()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var revenueProductArray: [ReportRevenueProduct] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var productChart: HorizontalBarChartView!
    
    
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
        
        // Report when network error
        productChart.noDataText = "Không có dữ liệu hiển thị, vui lòng kết nối mạng"
        
        
        //Định dạng ngày giờ hiển thị
        format.dateFormat = "dd/MM/yyyy"
        //Đặt tên nút mặc định
        chosseDay.setTitle("Hôm nay", for: .normal)
        
        thisDate()
       
        // Xoá đường line tableview
        self.tableView.separatorStyle = .none
        viewChartData()
    }
    
  
    // Thiết lập hiển thị bảng
    func viewChartData() {
        
        // Tuỳ chỉnh chữ hiện thị thi bấm vào
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1), font: .systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = productChart
        marker.minimumSize = CGSize(width: 80, height: 40)
        productChart.marker = marker
        self.setup(barLineChartView: productChart)
        
        productChart.delegate = self
        
        productChart.drawBarShadowEnabled = false
        productChart.drawValueAboveBarEnabled = true
        
        productChart.maxVisibleCount = 60
        
        
        let xAxis = productChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        xAxis.valueFormatter = LargeValueFormatter()
        
        let leftAxis = productChart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.valueFormatter = LargeValueFormatter()
        
        let rightAxis = productChart.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0
        rightAxis.valueFormatter = LargeValueFormatter()
        
        let l = productChart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        
        productChart.fitBars = true
    
        productChart.animate(yAxisDuration: 0.8)
    }

    func setup(barLineChartView chartView: BarLineChartViewBase) {
        productChart.chartDescription?.enabled = false
        
        productChart.dragEnabled = true
        productChart.setScaleEnabled(true)
        productChart.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
    }
    
    func updateChartData() {
        if self.shouldHideData {
            productChart.data = nil
            return
        }
    }
    
    // Lấy data để hiển thị:
    func viewData() {

        
        let barWidth = 0.8
        
        var productChartArr: [String] = []
        
        let block: (Int) -> BarChartDataEntry = {(i) -> BarChartDataEntry in
            productChartArr.append(self.revenueProductArray[i].itemname)
            print("Hiển thị món ăn \(productChartArr)")
            return BarChartDataEntry(x:Double(i), y: Double(self.revenueProductArray[i].totalamount) ?? 0.0)
        }
        
        let yVals: [BarChartDataEntry] = (0..<revenueProductArray.count).map(block)
        
        print("yVals: \(yVals)")
        print("DATAPRODUCT: \(productChartArr)")
        
        let set1 = BarChartDataSet(entries: yVals, label: "Sản phẩm")
        productChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: productChartArr)
        
        //Hiển thị toàn bộ label chart
        productChart.xAxis.granularity = 1
        // Ẩn line trên Chart
        productChart.xAxis.drawGridLinesEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.setValueFormatter(LargeValueFormatter())
        
        data.barWidth = barWidth
        
        //Fomat label
        productChart.xAxis.setLabelCount(productChartArr.count, force: false)
        set1.colors = ChartColorTemplates.vordiplom()
        
        productChart.data = data
        productChart.animate(xAxisDuration: 0.8, yAxisDuration: 0.8)
        productChart.setNeedsDisplay()
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
    
    
    //Lấy ngày hiện tại
    func thisDate() {
        dateChart.text = format.string(from: date)
        ReportRevenueProductAPI.getDataWithChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueProductArray = dayData
            self?.viewData()
        })
        ReportRevenueProductAPI.getDataWithoutChart(pstartdate: dateChart.text ?? "", penddate: dateChart.text ?? "", success: {[weak self] dayData in
            self?.revenueProductArray = dayData
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
        
        ReportRevenueProductAPI.getDataWithChart(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueProductArray = weekData
            self?.viewData()
        })
        ReportRevenueProductAPI.getDataWithChart(pstartdate: firstDay, penddate: lastDay, success: {[weak self] weekData in
            self?.revenueProductArray = weekData
        })
        
    }
    
    //MARK: Lấy data theo tháng trong năm
    func thisMonth () {
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!
        let startDateOfMonth = format.string(from: startOfMonth)
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar.date(byAdding: comps2, to: startOfMonth)!
        let endDateOfMonth = format.string(from: endOfMonth)
        
        dateChart.text = "Tháng \(month) năm \(year)"
        
        ReportRevenueProductAPI.getDataWithChart(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueProductArray = monthData
        })
        ReportRevenueProductAPI.getDataWithChart(pstartdate: startDateOfMonth, penddate: endDateOfMonth, success: {[weak self] monthData in
            self?.revenueProductArray = monthData
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
            
            ReportRevenueProductAPI.getDataWithChart(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueProductArray = yearData
                self?.viewData()
            })
            
            ReportRevenueProductAPI.getDataWithChart(pstartdate: startDateOfYear, penddate: lastDateOfYear, success: {[weak self] yearData in
                self?.revenueProductArray = yearData
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
        cell.totalamountLB.text = "Tổng doanh thu: \(revenueProductArray[indexPath.row].totaldiscount)đ"
        cell.totoaldiscountLB.text = "Tổng giảm giá: \(revenueProductArray[indexPath.row].totaldiscount)đ"
        return cell
    }
    
}

extension ReportRevenueProductViewController : CalendarDateRangePickerViewControllerDelegate {
    
    func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // Chọn ngày theo range
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        let startDay = format.string(from: startDate)
        let endDay = format.string(from: endDate)
        
        dateChart.text = "\(startDay) - \(endDay) "
        
        ReportRevenueProductAPI.getDataWithChart(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.revenueProductArray = chooseData
            self?.viewData()
        })
        ReportRevenueProductAPI.getDataWithChart(pstartdate: startDay, penddate: endDay, success: {[weak self] chooseData in
            self?.revenueProductArray = chooseData
        })
    }
    
}

//extension ReportRevenueProductViewController: IAxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return productChart?[Int(value) % productChart.count]
//    }
//}
