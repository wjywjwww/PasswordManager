//
//  AddNewPswTableViewCell.swift
//  PasswordManager
//
//  Created by sks on 2017/7/12.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AddNewPswTableViewCell: UITableViewCell {

    @IBOutlet weak var newPswBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        newPswBtn.layer.borderWidth = 0.5
        newPswBtn.layer.borderColor = ConvenienceTool.colorFromRGBA(red: 100, green: 100, blue: 100, alpha: 1).cgColor
        newPswBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
