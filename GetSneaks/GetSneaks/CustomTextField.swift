//
//  CustomTextField.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/12/17.
//  Copyright © 2017 FJ. All rights reserved.

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
