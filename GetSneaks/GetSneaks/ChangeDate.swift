//
//  ChangeDate.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/17/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ChangeDate: UIView {
    
    let changeDateLabel = UILabel()
    let changeDateTextField = UITextField()
    let submitButton = UIButton()
    let cancelButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configLayout() {
        // background color
        self.backgroundColor = UIColor.themeLightBlue
        
        // Label config
        changeDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(changeDateLabel)
        changeDateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        changeDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeDateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        changeDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        changeDateLabel.text = "Select the date you worked out below."
        changeDateLabel.textAlignment = .center
        changeDateLabel.font = UIFont(name: "Optima-ExtraBlack", size: 15)
        changeDateLabel.textColor = UIColor.white
        changeDateLabel.numberOfLines = 0
        changeDateLabel.lineBreakMode = .byWordWrapping
        
        // Textfield config
        changeDateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(changeDateTextField)
        changeDateTextField.topAnchor.constraint(equalTo: changeDateLabel.bottomAnchor, constant: 15).isActive = true
        changeDateTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        changeDateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        changeDateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        changeDateTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        changeDateTextField.layer.borderWidth = 2.0
        changeDateTextField.layer.borderColor = UIColor.white.cgColor
        changeDateTextField.layer.cornerRadius = 4.0
        changeDateTextField.attributedPlaceholder = NSAttributedString(string: " Click here to select date", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Italic", size: 15.0)!])
        
        // Buttons config
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
        submitButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        submitButton.setTitle("Select", for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Optima-ExtraBlack", size: 15)
        submitButton.titleLabel?.textColor = UIColor.white
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cancelButton)
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Optima-ExtraBlack", size: 15)
        cancelButton.setTitleColor(UIColor.themeLightGreen, for: .normal)
        
        let stackView = UIStackView()
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.addArrangedSubview(submitButton)
        stackView.addArrangedSubview(cancelButton)
        self.addSubview(stackView)
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: changeDateTextField.bottomAnchor, constant: 15).isActive = true
        stackView.widthAnchor.constraint(equalTo: changeDateTextField.widthAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.centerXAnchor.constraint(equalTo:self.centerXAnchor, constant: 0).isActive = true
    }
}

