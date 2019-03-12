//
//  UITextField+PickerView.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/10/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(10, 10, 10, 10)))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(10, 10, 10, 10)))
    }
}

extension CustomTextField {
    func loadDropdownData(data: [String]) {
        self.inputView = MyPickerCustomView(pickerData: data, pickerTextField: self)
    }
    
    func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
    }
    
    func donePicker() {
        self.endEditing(true)
    }
}
