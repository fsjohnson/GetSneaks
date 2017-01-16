//
//  NewWorkoutData.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/16/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import CoreData

class NewWorkoutData: UIView {
    
    // User input data
    var mileageLabel = UILabel()
    var mileageTextField = UITextField()
    var caloriesLabel = UILabel()
    var caloriesTextField = UITextField()
    var minutesLabel = UILabel()
    var minutesTextField = UITextField()
    var submitButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Config view
    func configLayout() {
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mileageLabel)
        mileageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        mileageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        mileageLabel.text = "Miles"
        mileageLabel.textColor = UIColor.white
        
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mileageTextField)
        mileageTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        mileageTextField.leadingAnchor.constraint(equalTo: mileageLabel.trailingAnchor, constant: 8).isActive = true
        mileageTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageTextField.font = UIFont(name: "Optima-Bold", size: 15.0)
        mileageTextField.attributedPlaceholder = NSAttributedString(string: "Miles", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Italic", size: 15.0)!])
        mileageTextField.textColor = UIColor.white
        mileageTextField.layer.borderWidth = 1.0
        mileageTextField.layer.borderColor = UIColor.white.cgColor
        mileageTextField.layer.cornerRadius = 4.0
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: mileageTextField.bottomAnchor, constant: 20).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(saveToCoreData), for: .touchUpInside)
    }
    
    func saveToCoreData() {
        print("button clicked")
        let managedContext = DataModel.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        guard let milesToSave = mileageTextField.text else { print("error with miles from textfield"); return }
        if let unwrappedEntity = entity {
            let newWorkout = Workout(context: managedContext)
            newWorkout.mileage = milesToSave
            DataModel.sharedInstance.saveContext()
        }
    }
}
