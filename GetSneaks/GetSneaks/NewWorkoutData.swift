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
    var containerView = UIView()
    var submitHealthKit = UIButton()
    var requestManual = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
        configHealthKitLayout()
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
        
        // Container view
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: submitInfoLabel.bottomAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // Today's date config
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YY"
        dateToSave = dateFormatter.string(from: date)
    }
    
    func configHealthKitLayout() {
        // Health kit view
        submitHealthKit.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(submitHealthKit)
        submitHealthKit.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        submitHealthKit.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        submitHealthKit.heightAnchor.constraint(equalToConstant: 40).isActive = true
        submitHealthKit.widthAnchor.constraint(equalToConstant: 200).isActive = true
        submitHealthKit.setTitle("Click here to submit your workout using Health Kit", for: .normal)
        submitHealthKit.setTitleColor(UIColor.white, for: .normal)
        submitHealthKit.titleLabel?.font = UIFont(name: "Optima-Bold", size: 15.0)
        submitHealthKit.titleLabel?.textAlignment = .center
        submitHealthKit.titleLabel?.numberOfLines = 0
        
        // Health kit view
        requestManual.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(requestManual)
        requestManual.topAnchor.constraint(equalTo: submitHealthKit.bottomAnchor, constant: 20).isActive = true
        requestManual.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        requestManual.heightAnchor.constraint(equalToConstant: 20).isActive = true
        requestManual.widthAnchor.constraint(equalToConstant: 200).isActive = true
        requestManual.setTitle("Want to manually input your workout stats? Click here!", for: .normal)
        requestManual.setTitleColor(UIColor.white, for: .normal)
        requestManual.titleLabel?.font = UIFont(name: "Optima-Bold", size: 15.0)
        requestManual.titleLabel?.textAlignment = .center
        requestManual.titleLabel?.numberOfLines = 0
        requestManual.addTarget(self, action: #selector(configManualInput), for: .touchUpInside)
    }
    
    func configManualInput() {
        // Remove health kit data 
        submitHealthKit.removeFromSuperview()
        requestManual.removeFromSuperview()
        
        // Mileage stack view
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mileageLabel)
        mileageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        mileageLabel.text = "Miles:"
        mileageLabel.textColor = UIColor.white
        mileageLabel.textAlignment = .center
        
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mileageTextField)
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
        containerView.addSubview(mileageStackView)
        mileageStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mileageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mileageStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        mileageStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Calories stack view
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(caloriesLabel)
        caloriesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        caloriesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        caloriesLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        caloriesLabel.text = "Calories:"
        caloriesLabel.textColor = UIColor.white
        caloriesLabel.textAlignment = .center
        
        caloriesTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(caloriesTextField)
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
        containerView.addSubview(caloriesStackView)
        caloriesStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        caloriesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        caloriesStackView.topAnchor.constraint(equalTo: mileageStackView.bottomAnchor, constant: 8).isActive = true
        caloriesStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Minutes stack view
        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(minutesLabel)
        minutesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        minutesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        minutesLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        minutesLabel.text = "Minutes:"
        minutesLabel.textColor = UIColor.white
        minutesLabel.textAlignment = .center
        
        minutesTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(minutesTextField)
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
        containerView.addSubview(minutesStackView)
        minutesStackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        minutesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        minutesStackView.topAnchor.constraint(equalTo: caloriesStackView.bottomAnchor, constant: 8).isActive = true
        minutesStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // Submit config
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: minutesStackView.bottomAnchor, constant: 8).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Optima-Bold", size: 15.0)
        
        // Not today button config
        notTodayButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(notTodayButton)
        notTodayButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 3).isActive = true
        notTodayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notTodayButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        notTodayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        notTodayButton.setTitle("Not today's date?", for: .normal)
        notTodayButton.setTitleColor(UIColor.themeLightGreen, for: .normal)
        notTodayButton.titleLabel?.font = UIFont(name: "Optima-BoldItalic", size: 12.0)
    }
    
    func saveToCoreData() {
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
