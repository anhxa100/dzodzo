//
//  Account.swift
//  dzodzo
//
//  Created by anhxa100 on 4/17/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

//typealias JSON = Dictionary<AnyHashable, Any>

class Account {
    let token: String?
    init(message: String, _token: String?) {
        self.token = _token
    }
}

extension Account {
    typealias DataBeforeValiDate = (username: String?, pass: String?)
    typealias DataAfterValiDate = (username: String, pass: String)
    
    static func valiDateLogin(input: DataBeforeValiDate,
                              success: ((DataAfterValiDate)-> ()),
                              failure: ((String)-> ())   ){
        
        guard let userData = input.username, !userData.isEmpty else
        {
            failure("Vui lòng nhập tên tài khoản")
            return
        }
//        guard userData.count >= 4 else {
//            failure("Trường user phải nhập từ 4 ký tự trở lên")
//            return
//        }
        guard !userData.contains(" ") else {
            failure("Tài khoản không được chứa ký tự trống, vui lòng nhập lại")
            return
        }
        guard  let passData = input.pass, !passData.isEmpty else {
            failure("Vui lòng nhập password")
            return
        }
        guard !passData.contains(" ") else {
            failure("Mật khẩu không được có ký tự trống, vui lòng nhập lại")
            return
        }
        success(DataAfterValiDate(username: userData, pass: passData))
        
    }
}
