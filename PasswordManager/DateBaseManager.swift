//
//  DateBaseManager.swift
//  PasswordManager
//
//  Created by sks on 2017/7/10.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit
class DateBaseManager: NSObject {
   let dataBasePath = NSHomeDirectory() + "/Documents/password.sqlite"
   static let shareManager = DateBaseManager()
    private override init() {
        super.init()
    }
    func creatDateBase(){
        if FileManager.default.fileExists(atPath: dataBasePath) {
           return
        }
        let db = FMDatabase(path: dataBasePath)
        if db.open(){
            let accountTable = "CREATE TABLE IF NOT EXISTS ACCONUTDATA (id  INTEGER PRIMARY KEY AUTOINCREMENT, account TEXT, company TEXT, companyImage TEXT)"
            let accountResult = db.executeStatements(accountTable)
            if accountResult{
                DPrint("新建数据库成功--新建表成功")
            }else{
                DPrint("新建数据库成功--新建表失败")
            }
            let pswTable = "CREATE TABLE IF NOT EXISTS PSWDATA (id  INTEGER PRIMARY KEY AUTOINCREMENT, account TEXT, password TEXT, passwordName TEXT ,company TEXT)"
            let pswResult = db.executeStatements(pswTable)
            if pswResult{
                DPrint("新建数据库成功--新建密码表成功")
            }else{
                DPrint("新建数据库成功--新建表密码失败")
            }
        }else{
            DPrint("新建数据库失败--新建表失败")
        }
        db.close()
    }
    func addAccountAndPsw( _ accountModel : AccountModel ){
        let db = FMDatabase(path: dataBasePath)
        if db.open(){
            let sql_insert = "INSERT INTO ACCONUTDATA (id, account, company, companyImage) VALUES(null,?,?,?);"
            let res = db.executeUpdate(sql_insert, withArgumentsIn: [accountModel.account , accountModel.company , accountModel.companyImage])
            if !res{
                db.close()
                DPrint("帐号数据插入失败 数据库无法打开")
                return
            }
            for pswModel in accountModel.pswArray{
                let sql_insert = "INSERT INTO PSWDATA (id, account, password, passwordName, company) VALUES(null,?,?,?,?);"
                let res = db.executeUpdate(sql_insert, withArgumentsIn: [pswModel.account , pswModel.password , pswModel.passwordName , pswModel.company])
                if !res{
                    db.close()
                    DPrint("密码数据插入失败")
                    return
                }
            }
        }
        DPrint("帐号密码插入成功")
        db.close()
    }
    //查询所有帐号数据
    func queryAccountAndPsw() -> [AccountModel]{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("查询所有帐号数据失败 数据库无法打开")
            db.close()
            return [AccountModel]()
        }
        let sqlStr = "SELECT * FROM ACCONUTDATA"
        do{
            let res = try db.executeQuery(sqlStr, values: nil)
            var accountArray = [AccountModel]()
            while res.next() {
                let accountStr = res.string(forColumn: "account") ?? ""
                let companyStr = res.string(forColumn: "company") ?? ""
                let companyImage = res.string(forColumn: "companyImage") ?? ""
                if accountStr == ""{
                    return [AccountModel]()
                }
                let account = AccountModel(with: accountStr, company: companyStr, companyImage:companyImage)
                accountArray.append(account)
            }
            db.close()
            for model in accountArray{
                let pswModelArray = queryPasswordModel(account: model.account, company: model.company)
                model.pswArray = pswModelArray
            }
            return accountArray
        }catch{
            DPrint("查询所有数据失败")
            db.close()
            return [AccountModel]()
        }
    }
    //根据公司名和帐号来查询当前帐号是否已经存在 如果返回False 则帐号已经存在不能再去存储
    func queryAccountExisted(_ account : String , company : String) -> Bool{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("检查帐号是否存在失败 数据库无法打开")
            db.close()
            return false
        }
        let sqlStr = "SELECT * FROM ACCONUTDATA WHERE account = ? AND company = ?"
        do{
            let res = try db.executeQuery(sqlStr, values: [account , company])
            if res.next() {
                db.close()
                DPrint("帐号已经存在")
                return false
            }else{
                db.close()
                return true
            }
        }catch{
            db.close()
            DPrint("检查帐号是否存在失败")
            return false
        }
    }
    //根据帐号和公司名来查询密码Model
    func queryPasswordModel(account : String , company : String) -> [PasswordModel]{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("查询密码Model失败 数据库无法打开")
             db.close()
            return [PasswordModel]()
        }
        let sqlStr = "SELECT * FROM PSWDATA WHERE account = ? AND company = ?"
        do{
            let res = try db.executeQuery(sqlStr, values: [account , company])
            var accountArray = [PasswordModel]()
            
            while res.next() {
                let accountStr = res.string(forColumn: "account") ?? ""
                let password = res.string(forColumn: "password") ?? ""
                let passwordName = res.string(forColumn: "passwordName") ?? ""
                let company = res.string(forColumn: "company") ?? ""
                if accountStr == ""{
                    return [PasswordModel]()
                }
                let account = PasswordModel(with: accountStr, password: password, passwordName: passwordName, company: company)
                accountArray.append(account)
            }
            db.close()
            return accountArray
        }catch{
            DPrint("查询密码Model失败")
            db.close()
            return [PasswordModel]()
        }
    }
    //更新帐号的密码
    func updatePassword(accountModel : AccountModel) -> Bool{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("修改数据失败 数据库无法打开")
            db.close()
            return false
        }
        for pswModel in accountModel.pswArray{
            let sqlStr = "UPDATE PSWDATA SET password = ? WHERE account = ? AND company = ? AND passwordName = ?"
            let result = db.executeUpdate(sqlStr, withArgumentsIn: [pswModel.password , pswModel.account, pswModel.company, pswModel.passwordName])
            if !result{
                DPrint("修改数据失败")
                db.close()
                return false
            }
        }
        db.close()
        return true
    }
    //删除一个帐号
    func deleteAccount(_ accountModel : AccountModel) -> Bool{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("删除帐号失败 数据库无法打开")
            db.close()
            return false
        }
        let sqlStr = "DELETE FROM ACCONUTDATA WHERE account = ? AND company = ?"
        let result = db.executeUpdate(sqlStr, withArgumentsIn: [accountModel.account,accountModel.company])
        if !result{
            DPrint("删除帐号失败")
            return false
        }
        db.close()
        _ = deleteAccountAllPassword(accountModel)
        return true
    }
    //删除帐号所有的密码
    func deleteAccountAllPassword(_ accountModel : AccountModel ) -> Bool{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("删除帐号所有的密码失败 数据库无法打开")
            db.close()
            return false
        }
        let sqlStr = "DELETE FROM PSWDATA WHERE account = ? AND company = ?"
        let result = db.executeUpdate(sqlStr, withArgumentsIn: [accountModel.account,accountModel.company])
        if !result{
            db.close()
            DPrint("删除帐号所有的密码失败")
            return false
        }
        db.close()
        return true
    }
    //删除一个帐号单独密码
    func deleteAccountOnePassword(_ passwordModel : PasswordModel) -> Bool{
        let db = FMDatabase(path: dataBasePath)
        if !db.open(){
            DPrint("删除帐号一个密码失败 数据库无法打开")
            db.close()
            return false
        }
        let sqlStr = "DELETE FROM PSWDATA WHERE account = ? AND company = ? AND passwordName = ?"
        let result = db.executeUpdate(sqlStr, withArgumentsIn: [passwordModel.account,passwordModel.company,passwordModel.passwordName])
        if !result{
            db.close()
            DPrint("删除帐号一个密码失败")
            return false
        }
        db.close()
        return true
    }
}

























