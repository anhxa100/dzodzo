//
//  DashBoardVC.swift
//  dzodzo
//
//  Created by anhxa100 on 4/18/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class DashBoardVC: VCTemplate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
       @IBAction func menuDashBoard(_ sender: Any) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
        }
        
        

        
    }

