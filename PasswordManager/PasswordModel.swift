//
//  PasswordModel.swift
//  PasswordManager
//
//  Created by sks on 2017/7/11.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class PasswordModel: NSObject {
    var account : String = ""
    var password : String = ""
    var passwordName : String = ""
    var company : String = ""
    init(with account : String , password : String ,  passwordName : String , company : String){
        super.init()
        self.account = account
        self.password = password
        self.passwordName = passwordName
        self.company = company
    }
    override init() {
        super.init()
    }
}
