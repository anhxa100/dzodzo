//
//  PopupChosseVC.swift
//  dzodzo
//
//  Created by anhxa100 on 4/24/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class PopupChosseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var resPicker: UIPickerView!
    
    
    private var dataRes: [SearchPoscode] = [] {
        didSet {
            resPicker.reloadAllComponents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        
        SearchPoscodeAPI.searchPosCode( success: {[weak self] pos in
            self?.dataRes = pos
            print("POS: \(pos)")
        })
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0 }, completion: {(finished: Bool) in
                if (finished) {
                    self.view.removeFromSuperview()
                }
        })
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        Switcher.updateRootVC()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataRes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataRes[1].name
    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        return
//    }
}
