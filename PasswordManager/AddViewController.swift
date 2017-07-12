//
//  AddViewController.swift
//  PasswordManager
//
//  Created by sks on 2017/7/10.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var newPswTable: UITableView!
    var accountModel = AccountModel()
    var numberOfRows = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        newPswTable.tableFooterView = UIView()
        newPswTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // Do any additional setup after loading the view.
        accountModel.pswArray = [PasswordModel()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Table View Delegate DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountModel.pswArray.count + 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! AddCompanyTableViewCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addAccountCell", for: indexPath) as! AddAccountTableViewCell
            return cell
        }
        else if indexPath.row > 0 && indexPath.row < accountModel.pswArray.count + 3 - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath) as! AddPswTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newPasswordCell", for: indexPath) as! AddNewPswTableViewCell
            cell.newPswBtn.addTarget(nil, action: #selector(AddViewController.addNewPswCell), for: UIControlEvents.touchUpInside)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < numberOfRows - 1 {
            return 70
        }else{
            return 50
        }
    }
    //MARK: - Actions
    //添加新密码类型
    func addNewPswCell(){
        
        accountModel.pswArray.append(PasswordModel())
        newPswTable.reloadData()
        
        let indexPath = IndexPath(row: accountModel.pswArray.count + 3 - 2, section: 0)
        newPswTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
}
