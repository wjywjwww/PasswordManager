//
//  AddCompanyTableViewCell.swift
//  PasswordManager
//
//  Created by sks on 2017/7/12.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class AddCompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var companyImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
