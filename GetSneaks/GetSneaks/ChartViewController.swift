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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config view
        configLayout()

        // Config container view
        configChartContainerView()
        
        // Config segmented control
        configSegmentedControl()
        
        // Config post new workout
        configNewWorkoutDataView()
        
        // Config keyboard 
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        getSneaksTop.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // initial chart layout
        populateChartData()
        getChartData(with: dates, values: miles, legend: "Miles")
        barChartConfig()
        
        // background color
        self.view.backgroundColor = UIColor.themeMediumBlue
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
        segmentedControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
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
        }
    }
    
    // New workout data viw 
    func configNewWorkoutDataView() {
        newWorkoutData = NewWorkoutData()
        newWorkoutData.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newWorkoutData)
        newWorkoutData.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        newWorkoutData.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        newWorkoutData.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        newWorkoutData.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
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
        
        DataModel.sharedInstance.fetchWorkoutData()
        workouts = DataModel.sharedInstance.workouts
        
        for workout in workouts {
            guard let mile = workout.mileage else { return }
            miles.append(mile)
        }
        
        workoutDuration = ["60.0", "100.0", "300.0", "90.0"]
        dates = ["1", "2", "3", "5"]
        miles = ["101.0", "80.0", "70.0", "200.0"]
        calories = ["300.0", "400.0", "200.0", "100.0"]
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

