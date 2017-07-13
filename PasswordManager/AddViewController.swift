//
//  AddViewController.swift
//  PasswordManager
//
//  Created by sks on 2017/7/10.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var newPswTable: UITableView!
    var accountModel = AccountModel()
    var numberOfRows = 3
    var pswTypePicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        newPswTable.tableFooterView = UIView()
        newPswTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // Do any additional setup after loading the view.
        accountModel.pswArray = [PasswordModel(passwordName: "密码类型")]
        pswTypePicker.dataSource = self
        pswTypePicker.delegate = self
        self.view.addSubview(pswTypePicker)
        pswTypePicker.center = CGPoint(x: ConvenienceTool.SCREEN_WIDTH / 2, y: ConvenienceTool.SCREENH_HEIGHT - 100)
        designPicker()
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
        else if indexPath.row > 1 && indexPath.row < accountModel.pswArray.count + 3 - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath) as! AddPswTableViewCell
            let model = accountModel.pswArray[indexPath.row - 2]
            cell.pswTypeBtn.setTitle(model.passwordName, for: UIControlState.normal)
            cell.passwordModel = model
            cell.passwordTF.text = model.password
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row > 2 && indexPath.row < accountModel.pswArray.count + 3 - 1{
            return true
        }else{
            return false
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        accountModel.pswArray.remove(at: indexPath.row - 2)
        newPswTable.reloadData()
//        let indexPath = IndexPath(row: accountModel.pswArray.count + 3 - 1, section: 0)
//        newPswTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.top)
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //MARK: - Picker Data source Picker Delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ["登录密码","查询密码","消费密码","取款密码"][row]
    }
    //MARK: - Actions
    //添加新密码类型
    func addNewPswCell(){
        accountModel.pswArray.append(PasswordModel(passwordName: "密码类型"))
        newPswTable.reloadData()
        let indexPath = IndexPath(row: accountModel.pswArray.count + 3 - 2, section: 0)
        newPswTable.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    func selectPswType(indexPath : IndexPath){
        
    }
    func designPicker(){
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: ConvenienceTool.SCREEN_WIDTH, height: 44))
        let tempFex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        tempFex.width = ConvenienceTool.SCREEN_WIDTH - 100
        let cancelItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.done, target: nil, action: #selector(AddViewController.cancelClick))
        let finishItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: nil, action: #selector(AddViewController.finishClick))
        toolBar.items = [cancelItem,tempFex,finishItem]
        toolBar.frame = CGRect(x: 0, y: ConvenienceTool.SCREENH_HEIGHT - 200, width: ConvenienceTool.SCREEN_WIDTH, height: 44)
        self.view.addSubview(toolBar)
    }
    func finishClick(){
        
    }
    func cancelClick(){
        
    }
}



















