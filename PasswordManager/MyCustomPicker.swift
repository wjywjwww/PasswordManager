//
//  MyCustomPicker.swift
//  PasswordManager
//
//  Created by sks on 2017/7/14.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class MyCustomPicker: UIView {
    var picker : UIPickerView = UIPickerView()
    weak var delegate : MyCustomPickerDeleagte?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
protocol MyCustomPickerDeleagte : class {
    func selectCell(_ cellStr : String)
    func cancel()
}
