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
    var submitInfoLabel = UILabel()
    var mileageLabel = UILabel()
    var mileageTextField = UITextField()
    var caloriesLabel = UILabel()
    var caloriesTextField = UITextField()
    var minutesLabel = UILabel()
    var minutesTextField = UITextField()
    var submitButton = UIButton()
    var dateToSave = String()
    var notTodayButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Config view
    func configLayout() {
        // Submit header config
        submitInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitInfoLabel)
        submitInfoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        submitInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitInfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        submitInfoLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        submitInfoLabel.font = UIFont(name: "Optima-ExtraBlack", size: 20)
        submitInfoLabel.text = "Record Today's Workout"
        submitInfoLabel.textColor = UIColor.themeLightBlue
        submitInfoLabel.textAlignment = .center
        
        // Mileage stack view
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mileageLabel)
        mileageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        mileageLabel.text = "Miles:"
        mileageLabel.textColor = UIColor.white
        mileageLabel.textAlignment = .center
        
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mileageTextField)
        mileageTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageTextField.font = UIFont(name: "Optima-Bold", size: 15.0)
        mileageTextField.textAlignment = .center
        mileageTextField.attributedPlaceholder = NSAttributedString(string: "Miles", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Italic", size: 15.0)!])
        mileageTextField.textColor = UIColor.white
        mileageTextField.layer.borderWidth = 1.0
        mileageTextField.layer.borderColor = UIColor.white.cgColor
        mileageTextField.layer.cornerRadius = 4.0
        mileageTextField.keyboardType = .numberPad
        
        let mileageStackView = UIStackView()
        mileageStackView.axis = UILayoutConstraintAxis.horizontal
        mileageStackView.distribution  = UIStackViewDistribution.fillProportionally
        mileageStackView.alignment = UIStackViewAlignment.center
        mileageStackView.addArrangedSubview(mileageLabel)
        mileageStackView.addArrangedSubview(mileageTextField)
        mileageStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mileageStackView)
        mileageStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mileageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mileageStackView.topAnchor.constraint(equalTo: submitInfoLabel.bottomAnchor, constant: 8).isActive = true
        mileageStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Calories stack view
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(caloriesLabel)
        caloriesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        caloriesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        caloriesLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        caloriesLabel.text = "Calories:"
        caloriesLabel.textColor = UIColor.white
        caloriesLabel.textAlignment = .center
        
        caloriesTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(caloriesTextField)
        caloriesTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        caloriesTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        caloriesTextField.font = UIFont(name: "Optima-Bold", size: 15.0)
        caloriesTextField.textAlignment = .center
        caloriesTextField.attributedPlaceholder = NSAttributedString(string: "Calories", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Italic", size: 15.0)!])
        caloriesTextField.textColor = UIColor.white
        caloriesTextField.layer.borderWidth = 1.0
        caloriesTextField.layer.borderColor = UIColor.white.cgColor
        caloriesTextField.layer.cornerRadius = 4.0
        caloriesTextField.keyboardType = .numberPad
        
        let caloriesStackView = UIStackView()
        caloriesStackView.axis = UILayoutConstraintAxis.horizontal
        caloriesStackView.distribution  = UIStackViewDistribution.fillProportionally
        caloriesStackView.alignment = UIStackViewAlignment.center
        caloriesStackView.addArrangedSubview(caloriesLabel)
        caloriesStackView.addArrangedSubview(caloriesTextField)
        caloriesStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(caloriesStackView)
        caloriesStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        caloriesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        caloriesStackView.topAnchor.constraint(equalTo: mileageStackView.bottomAnchor, constant: 8).isActive = true
        caloriesStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Minutes stack view
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minutesLabel)
        minutesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        minutesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        minutesLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        minutesLabel.text = "Minutes:"
        minutesLabel.textColor = UIColor.white
        minutesLabel.textAlignment = .center
        
        minutesTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minutesTextField)
        minutesTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        minutesTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        minutesTextField.font = UIFont(name: "Optima-Bold", size: 15.0)
        minutesTextField.textAlignment = .center
        minutesTextField.attributedPlaceholder = NSAttributedString(string: "Minutes", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Italic", size: 15.0)!])
        minutesTextField.textColor = UIColor.white
        minutesTextField.layer.borderWidth = 1.0
        minutesTextField.layer.borderColor = UIColor.white.cgColor
        minutesTextField.layer.cornerRadius = 4.0
        minutesTextField.keyboardType = .numberPad
        
        let minutesStackView = UIStackView()
        minutesStackView.axis = UILayoutConstraintAxis.horizontal
        minutesStackView.distribution  = UIStackViewDistribution.fillProportionally
        minutesStackView.alignment = UIStackViewAlignment.center
        minutesStackView.addArrangedSubview(minutesLabel)
        minutesStackView.addArrangedSubview(minutesTextField)
        minutesStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minutesStackView)
        minutesStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        minutesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        minutesStackView.topAnchor.constraint(equalTo: caloriesStackView.bottomAnchor, constant: 8).isActive = true
        minutesStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Submit config
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: minutesStackView.bottomAnchor, constant: 8).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(saveToCoreData), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 15.0)
        
        // Not today button config
        notTodayButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(notTodayButton)
        notTodayButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 3).isActive = true
        notTodayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notTodayButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        notTodayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        notTodayButton.setTitle("Not today's date?", for: .normal)
        notTodayButton.setTitleColor(UIColor.themeLightGreen, for: .normal)
        notTodayButton.titleLabel?.font = UIFont(name: "Optima-BoldItalic", size: 12.0)
        
        // Today's date config 
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateToSave = dateFormatter.string(from: date)
    }
    
    func saveToCoreData() {
        print("button clicked")
        let managedContext = DataModel.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        
        // textfield data
        guard let milesToSave = mileageTextField.text else { print("error with miles from textfield"); return }
        guard let caloriesToSave = caloriesTextField.text else { print("error with miles from textfield"); return }
        guard let minutesToSave = minutesTextField.text else { print("error with miles from textfield"); return }
        
        if let unwrappedEntity = entity {
            let newWorkout = Workout(context: managedContext)
            newWorkout.mileage = milesToSave
            newWorkout.calorie = caloriesToSave
            newWorkout.minute = minutesToSave
            newWorkout.workoutDate = dateToSave
            DataModel.sharedInstance.saveContext()
        }
    }
}
