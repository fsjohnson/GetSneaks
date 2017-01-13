//
//  AddDataViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/13/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController {
    
    // User input data
    var mileageLabel = UILabel()
    var mileageTextField = UITextField()
    var submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        configLayout()
    }

    // Config view
    func configLayout() {
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mileageLabel)
        mileageLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        mileageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageLabel.font = UIFont(name: "Helvetica", size: 20.0)
        mileageLabel.text = "Miles"
        mileageLabel.backgroundColor = UIColor.blue
        
        mileageTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mileageTextField)
        mileageTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        mileageTextField.leadingAnchor.constraint(equalTo: mileageLabel.trailingAnchor, constant: 8).isActive = true
        mileageTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mileageTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mileageTextField.font = UIFont(name: "Helvetica", size: 12.0)
        mileageTextField.placeholder = "Enter here"
        mileageTextField.backgroundColor = UIColor.orange
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: mileageTextField.bottomAnchor, constant: 20).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.blue
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
