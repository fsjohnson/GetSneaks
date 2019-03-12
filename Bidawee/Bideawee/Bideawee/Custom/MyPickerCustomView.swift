//
//  MyPickerCustomView.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/10/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

class MyPickerCustomView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData: [String]
    var pickerTextField: UITextField
    
    init(pickerData: [String], pickerTextField: UITextField) {
        
        self.pickerData = pickerData
        self.pickerTextField = pickerTextField
        
        super.init(frame: .zero)
        
        self.delegate = self
        self.dataSource = self
        self.showsSelectionIndicator = true
        
        if pickerData.count > 0 {
            self.pickerTextField.text = self.pickerData[0]
            self.pickerTextField.isEnabled = true
        } else {
            self.pickerTextField.text = nil
            self.pickerTextField.isEnabled = false
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerTextField.text = pickerData[row]
    }
}
