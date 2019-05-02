//
//  ViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 4/16/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {

    @IBOutlet weak var useNameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    private var poscode: [CheckPoscode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        // Do any additional setup after loading the view.
    }
    
    static var instance: LoginVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginVC
    }
   
    
    @IBAction func oneClickLogin(_ sender: Any) {
        
        let inputValidate = Account.DataBeforeValiDate(username: useNameTF.text, pass: passTF.text)
        
        Account.valiDateLogin(input: inputValidate, success: { [weak self] outPut in
            // Gọi API login và show loading
            AccountAPI.login(with: outPut, result: { acc in
                DispatchQueue.main.async {
                    if let token = acc.token, token != "LoginFail" {
                        
                        print(token)
                                    
                        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoginKey)
                        UserDefaults.standard.set(token, forKey: UserDefaultKeys.tokenKey)
                        UserDefaults.standard.set(outPut.username, forKey: UserDefaultKeys.usernameKey)
                        UserDefaults.standard.set(outPut.pass, forKey: UserDefaultKeys.passwordKey)
                        
                        PosCodeAPI.getPoscode(success: {[weak self] code in
                            self?.poscode = code
                            
                            print(self?.poscode)
                            
                            
                            Switcher.updateRootVC()
                        })
                        
                        
                        
                    } else {
                        self?.errorAlert(message: "Sai tài khoản hoặc mật khẩu, Vui lòng thử lại!")
                    }
                    
                }
            })
            
            
            }, failure: {[weak self] in
                self?.errorAlert(message: $0)
        } )
        
//        print("Pressed!")
        view.endEditing(true)
        
    }
    
    
    @IBAction func fogetPass(_ sender: Any) {
        print("forget pass")
    }
    @IBAction func signUp(_ sender: Any) {
        print("Sign up")
    }
    
    
    private func errorAlert(message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let doneAcion = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(doneAcion)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

