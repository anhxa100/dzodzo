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

        // Do any additional setup after loading the view.
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
        UserDefaults.standard.set(false, forKey: "isLogin")
        Switcher.updateRootVC()
    }
    

}
