//
//  AddPswTableViewCell.swift
//  PasswordManager
//
//  Created by sks on 2017/7/12.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AddPswTableViewCell: UITableViewCell {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var pswTypeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        pswTypeBtn.layer.borderWidth = 0.5
        pswTypeBtn.layer.borderColor = ConvenienceTool.colorFromRGBA(red: 100, green: 100, blue: 100, alpha: 1).cgColor
        pswTypeBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
