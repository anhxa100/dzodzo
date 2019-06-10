//
//  ViewController.swift
//  dzodzo
//
//  Created by anhxa100 on 4/16/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit
import Alamofire
import HideShowPasswordTextField


class LoginVC: UIViewController {
    
    @IBOutlet weak var useNameTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    private var CodeKey: [CheckPoscode] = []
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }
        
        if Connectivity.isConnectedToInternet() == false {
            alertLogin()
            print("No have internet")
        }
    }
    
    static var instance: LoginVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginVC
    }
    
    
    @IBAction func oneClickLogin(_ sender: Any) {
        
        let inputValidate = Account.DataBeforeValiDate(username: useNameTF.text, pass: passTF.text)
        
        Account.valiDateLogin(input: inputValidate, success: { [weak self] outPut in
            // Gọi API login và show loading
            if Connectivity.isConnectedToInternet(){
                AccountAPI.login(with: outPut, result: { acc in
                    DispatchQueue.main.async {
                        if let token = acc.token, token != "LoginFail" {
                            
                            print(token)
                            
                            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoginKey)
                            UserDefaults.standard.set(token, forKey: UserDefaultKeys.tokenKey)
                            UserDefaults.standard.set(outPut.username, forKey: UserDefaultKeys.usernameKey)
                            UserDefaults.standard.set(outPut.pass, forKey: UserDefaultKeys.passwordKey)
                            
                            PosCodeAPI.getPoscode(success: {[weak self] code in
                                self?.CodeKey = code
                                let poscodegroupData = self?.CodeKey[0].posgroupcode
                                let poscodeData = self?.CodeKey[0].poscode
                                
                                // Save posgroupcode vao UserDefault
                                UserDefaults.standard.set(poscodegroupData, forKey: UserDefaultKeys.posgroupKey)
                                UserDefaults.standard.set(poscodeData, forKey: UserDefaultKeys.poscodeKey)
                                
                                //Switch sang man hinh popup
                                if self?.CodeKey[0].poscode != "" {
                                    Switcher.updateRootVC()
                                }else{
                                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cbPopUpId") as! PopupChosseVC
                                    self?.addChild(popOverVC)
                                    popOverVC.view.frame = (self?.view.frame)!
                                    self?.view.addSubview(popOverVC.view)
                                    popOverVC.didMove(toParent: self)
                                }
                            })
                            
                        } else {
                            self?.errorAlert(message: "Sai tài khoản hoặc mật khẩu, Vui lòng thử lại!")
                        }
                        
                    }
                })
                
            }else{
                alertLogin()
            }
            
            
            }, failure: {[weak self] in
                self?.errorAlert(message: $0)
                self?.alertLogin()
        } )
        
        //        print("Pressed!")
        view.endEditing(true)
        
    }
    
    func alertLogin() {
        let alertController = UIAlertController(title: "Không có kết nối internet", message: "Vui lòng kiểm tra kết nối wifi/3G", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func fogetPass(_ sender: Any) {
        print("forget pass")
        
        openUrl(urlStr: "https://dzodzo.com.vn/pos/resetpswd.html")
    }
    @IBAction func signUp(_ sender: Any) {
        openUrl(urlStr: "https://dzodzo.com.vn/pos/register.html")
        
        print("Sign up")
    }
    
    //show/hide pass
    @IBAction func iconAction(sender: UIButton) {
        if(iconClick == true) {
            passTF.isSecureTextEntry = false
        } else {
            passTF.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
        sender.isSelected = !sender.isSelected
        
    }
    
    func openUrl(urlStr: String!) {
        if let url = URL(string:urlStr), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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



