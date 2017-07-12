//
//  PswTableViewCell.swift
//  PasswordManager
//
//  Created by sks on 2017/7/7.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class PswTableViewCell: UITableViewCell {

    @IBOutlet weak var passwordName: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var pswLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.companyImage.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
