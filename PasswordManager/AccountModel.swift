//
//  AccountModel.swift
//  PasswordManager
//
//  Created by sks on 2017/7/11.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AccountModel: NSObject {
    var account : String = ""
    var company : String = ""
    var companyImage : String = ""
    var pswArray : [PasswordModel] = [PasswordModel]()
    init(with account : String , company : String ,  companyImage : String ,  pswArray : [PasswordModel] = [PasswordModel]() ){
        super.init()
        self.account = account
        self.company = company
        self.companyImage = companyImage
        self.pswArray = pswArray
    }
    override init() {
        super.init()
    }
}
