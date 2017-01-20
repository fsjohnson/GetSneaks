//
//  ChartViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/4/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import Charts
import Foundation
import CoreData
import EventKit

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String], legend: String)
    var workoutDuration: [String] {get set}
    var calories: [String] {get set}
    var miles: [String] {get set}
    var dates: [String] {get set}
    var legend: String {get set}
}

class ChartViewController: UIViewController, GetChartData, UIScrollViewDelegate {
    
    // Views
    var historyLabel = UILabel()
    var getSneaksTop: GetSneaksTop!
    
    // Chart data
    var workoutDuration = [String]()
    var calories = [String]()
    var dates = [String]()
    var miles = [String]()
    var legend = String()
    var workouts = [Workout]()
    var chartContainerView = UIView()
    let barChart = BarChart()
    
    // Segmented controller
    var segmentedControl = UISegmentedControl(items: ["Miles", "Calories", "Minutes", "Old Sneaks"])
    
    // New wokrout data
    var newWorkoutData: NewWorkoutData!
    
    // Change date
    var changeDate: ChangeDate!
    let datePickerView = UIDatePicker()
    var backgroundView = UIView()
    
    // No data
    var noWorkoutData = NoWorkoutData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config view
        configLayout()
        
        // initial chart layout
        initialLayout()
        
        // Config segmented control
        configSegmentedControl()
        
        // Config post new workout
        configNewWorkoutDataView()
        
        // Config keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        hideKeyboardWhenTappedAround(isActive: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateChartData()
        if workouts.count == 0 {
            noDataConfig()
        } else {
            if chartContainerView.subviews.contains(noWorkoutData) {
                noWorkoutData.removeFromSuperview()
            }
            segmentedControl.selectedSegmentIndex = 0
            getChartData(with: dates, values: miles, legend: "Miles")
            barChartConfig()
            getSneaksTop.populateMilesCompleted()
        }
    }
    
    // Config view
    func configLayout() {
        // getSneaks View
        getSneaksTop = GetSneaksTop()
        getSneaksTop.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(getSneaksTop)
        getSneaksTop.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        getSneaksTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        getSneaksTop.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        getSneaksTop.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        // background color
        self.view.backgroundColor = UIColor.themeMediumBlue
    }
    
    // Initial layout config
    func initialLayout() {
        configChartContainerView()
        populateChartData()
        if workouts.count == 0 {
            noDataConfig()
        } else {
            getChartData(with: dates, values: miles, legend: "Miles")
            barChartConfig()
        }
    }
    
    // Container view for charts
    func configChartContainerView() {
        self.view.addSubview(chartContainerView)
        chartContainerView.translatesAutoresizingMaskIntoConstraints = false
        chartContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        chartContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        chartContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        chartContainerView.topAnchor.constraint(equalTo: getSneaksTop.bottomAnchor, constant: 0).isActive = true
        chartContainerView.tintColor = UIColor.themeMediumBlue
    }
    
    // Config segmented control
    func configSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        segmentedControl.heightAnchor.constraint(equalToConstant: 17).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: chartContainerView.bottomAnchor, constant: 8).isActive = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlSegues), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Bold", size: 13.0)!], for: .normal)
        segmentedControl.tintColor = UIColor.white
    }
    
    func segmentedControlSegues(sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            populateChartData()
            getChartData(with: dates, values: miles, legend: "Miles")
            barChartConfig()
        } else if sender.selectedSegmentIndex == 1 {
            populateChartData()
            getChartData(with: dates, values: calories, legend: "Calories")
            barChartConfig()
        } else if sender.selectedSegmentIndex == 2 {
            populateChartData()
            getChartData(with: dates, values: workoutDuration, legend: "Minutes")
            barChartConfig()
        } else if sender.selectedSegmentIndex == 3 {
            performSegue(withIdentifier: "previousWorkouts", sender: self)
        }
    }
    
    // New workout data view
    func configNewWorkoutDataView() {
        newWorkoutData = NewWorkoutData()
        newWorkoutData.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newWorkoutData)
        newWorkoutData.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        newWorkoutData.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        newWorkoutData.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        newWorkoutData.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15).isActive = true
        
        // submitButtonAlert
        newWorkoutData.submitButton.addTarget(self, action: #selector(workoutAreYouSureAlert), for: .touchUpInside)
        
        // notTodaysDateButton
        newWorkoutData.notTodayButton.addTarget(self, action: #selector(notTodaysDate), for: .touchUpInside)
    }
    
    func workoutAreYouSureAlert() {
        self.dismissKeyboard()
        if (newWorkoutData.caloriesTextField.text == "") || (newWorkoutData.mileageTextField.text == "") || (newWorkoutData.minutesTextField.text == "") {
            let alert = UIAlertController(title: "Oops!", message: "Please fill out all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Are you sure?", message: "Do you want to save this workout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.newWorkoutData.saveToCoreData()
                self.submitButtonSuccess()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func submitButtonSuccess() {
        let alert = UIAlertController(title: "Success", message: "You have recorded a new workout. GO YOU!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { success in
            self.getSneaksTop.populateMilesCompleted()
            self.populateChartData()
            self.barChartConfig()
            self.newWorkoutData.mileageTextField.text = ""
            self.newWorkoutData.caloriesTextField.text = ""
            self.newWorkoutData.minutesTextField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func notTodaysDate() {
        // background View
        self.view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        //change date view
        changeDate = ChangeDate()
        self.view.addSubview(changeDate)
        changeDate.translatesAutoresizingMaskIntoConstraints = false
        changeDate.heightAnchor.constraint(equalToConstant: 150).isActive = true
        changeDate.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor, constant: -20).isActive = true
        changeDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeDate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        self.datePickerView.datePickerMode = UIDatePickerMode.date
        changeDate.changeDateTextField.inputView = self.datePickerView
        self.datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: .valueChanged)
        self.changeDate.submitButton.addTarget(self, action: #selector(submitButton), for: .touchUpInside)
        self.changeDate.cancelButton.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        changeDate.layer.cornerRadius = 4.0
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YY"
        newWorkoutData.dateToSave = dateFormatter.string(from: sender.date)
        changeDate.changeDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func submitButton() {
        self.backgroundView.removeFromSuperview()
        self.changeDate.removeFromSuperview()
    }
    
    func cancelButton() {
        backgroundView.removeFromSuperview()
        changeDate.removeFromSuperview()
    }
    
    // Keyboard notification funcs
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    // Conform to protocol
    func getChartData(with dataPoints: [String], values: [String], legend: String) {
        self.workoutDuration = values
        self.miles = values
        self.calories = values
        self.dates = dataPoints
        self.legend = legend
    }
    
    // Populate data
    func populateChartData() {
        workoutDuration.removeAll()
        calories.removeAll()
        dates.removeAll()
        miles.removeAll()
        
        DataModel.sharedInstance.fetchWorkoutData()
        workouts = DataModel.sharedInstance.workouts
        
        workouts.sort { (workoutOne, workoutTwo) -> Bool in
            workoutOne.workoutDate! < workoutTwo.workoutDate!
        }
        for workout in workouts {
            guard let mile = workout.mileage else { print("core data mile error"); return }
            guard let calorie = workout.calorie else { print("core data calories error");return }
            guard let minute = workout.minute else { print("core data minutes error");return }
            guard let date = workout.workoutDate else { print("core data calories error");return }
            workoutDuration.append(minute)
            calories.append(calorie)
            dates.append(date)
            miles.append(mile)
        }
    }
    
    // No data config
    func noDataConfig() {
        self.chartContainerView.addSubview(noWorkoutData)
        noWorkoutData.translatesAutoresizingMaskIntoConstraints = false
        noWorkoutData.heightAnchor.constraint(equalToConstant: 200).isActive = true
        noWorkoutData.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor, constant: -20).isActive = true
        noWorkoutData.topAnchor.constraint(equalTo: chartContainerView.topAnchor, constant: 0).isActive = true
        noWorkoutData.centerXAnchor.constraint(equalTo: chartContainerView.centerXAnchor).isActive = true
    }
    
    // Bar chart config
    func barChartConfig() {
        self.chartContainerView.addSubview(barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 200).isActive = true
        barChart.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor, constant: -20).isActive = true
        barChart.topAnchor.constraint(equalTo: chartContainerView.topAnchor, constant: 0).isActive = true
        barChart.centerXAnchor.constraint(equalTo: chartContainerView.centerXAnchor).isActive = true
        barChart.delegate = self
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previousWorkouts" {
        }
    }
}

// MARK: - ChartFormatter required to config xaxis
public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    var dates = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dates[Int(value)]
    }
    public func setValues(values: [String]) {
        self.dates = values
    }
}

// MARK: - Hide keyboard when tap around
extension UIViewController {
    func hideKeyboardWhenTappedAround(isActive: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        if isActive == true {
            view.addGestureRecognizer(tap)
        } else {
            view.removeGestureRecognizer(tap)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

