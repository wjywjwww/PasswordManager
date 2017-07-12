//
//  ViewController.swift
//  PasswordManager
//
//  Created by sks on 2017/7/7.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var pswTableView: UITableView!
    var dataArray = [AccountModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pswTableView.tableFooterView = UIView()
        self.pswTableView.rowHeight = 70
        self.pswTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let pswModel1 = PasswordModel(with: "wjywjwww", password: "12356", passwordName: "登录密码", company: "支付宝")
        let pswModel2 = PasswordModel(with: "wjywjwww", password: "123456789", passwordName: "消费密码", company: "支付宝")
        let account = AccountModel(with: "wjywjwww", company: "支付宝", companyImage: "电信", pswArray: [pswModel1,pswModel2])
//        DateBaseManager.shareManager.addAccountAndPsw(account)
//        pswModel1.password = "987654321"
//        DateBaseManager.shareManager.updatePassword(accountModel: account)
//        DateBaseManager.shareManager.deleteAccount(account)
        dataArray = DateBaseManager.shareManager.queryAccountAndPsw()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pswCell", for: indexPath) as! PswTableViewCell
        let model = dataArray[indexPath.row]
        cell.companyImage.image = UIImage(named: model.companyImage)
        cell.companyLabel.text = model.company
        cell.accountLabel.text = model.account
        cell.pswLabel.text = model.pswArray.first?.password
        let passwordName = model.pswArray.first?.passwordName ?? "密码"
        cell.passwordName.text = passwordName + "："
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let time = DispatchTime.now() + DispatchTimeInterval.seconds(Int(0.1))
        DispatchQueue.main.asyncAfter(deadline: time) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


