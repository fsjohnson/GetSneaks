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
    var beatsPerMinute: [String] {get set}
    var milesWorkoutDuration: [String] {get set}
    var milesBeatsPerMinute: [String] {get set}
    var legend: String {get set}
}

class ChartViewController: UIViewController, GetChartData, UIScrollViewDelegate {
    
    // Views
    var historyLabel = UILabel()
    var getSneaksTop: GetSneaksTop!
    
    // Chart data
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    var milesWorkoutDuration = [String]()
    var milesBeatsPerMinute = [String]()
    var legend = String()
    var miles = [String]()
    var workouts = [Workout]()
    var chartContainerView = UIView()
    let barChart = BarChart()
    
    // Segmented controller
    var segmentedControl = UISegmentedControl(items: ["Miles", "Calories", "Old Sneaks"])
    
    // Post Workout
    var postWorkoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config view
        configLayout()

        // Config container view
        configChartContainerView()
        
        // Config segmented control
        configSegmentedControl()
        
        // Config post new workout
        workoutButton()
    }
    
    // Config view
    func configLayout() {
        // getSneaks View
        getSneaksTop = GetSneaksTop()
        getSneaksTop.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(getSneaksTop)
        getSneaksTop.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        getSneaksTop.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        getSneaksTop.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        getSneaksTop.heightAnchor.constraint(equalToConstant: 162).isActive = true
        
        // initial chart layout
        populateChartData()
        self.getChartData(with: milesWorkoutDuration, values: milesBeatsPerMinute, legend: "Miles")
        barChartConfig()
        
        // background color
        self.view.backgroundColor = UIColor.themeMediumBlue
    }
    
    // Container view for charts
    func configChartContainerView() {
        self.view.addSubview(chartContainerView)
        chartContainerView.translatesAutoresizingMaskIntoConstraints = false
        chartContainerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        chartContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        chartContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        chartContainerView.topAnchor.constraint(equalTo: getSneaksTop.bottomAnchor, constant: 0).isActive = true
        chartContainerView.tintColor = UIColor.themeMediumBlue
    }
    
    // Config segmented control
    func configSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: chartContainerView.bottomAnchor, constant: 8).isActive = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlSegues), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont(name: "Optima-Bold", size: 15.0)!], for: .normal)
        segmentedControl.tintColor = UIColor.white
    }
    
    func segmentedControlSegues(sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            populateChartData()
            self.getChartData(with: milesWorkoutDuration, values: milesBeatsPerMinute, legend: "Miles")
            barChartConfig()
        } else if sender.selectedSegmentIndex == 1 {
            populateChartData()
            self.getChartData(with: workoutDuration, values: beatsPerMinute, legend: "Calories")
            barChartConfig()
        }
    }
    
    // Post workout button
    func workoutButton() {
        postWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(postWorkoutButton)
        postWorkoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        postWorkoutButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8).isActive = true
        postWorkoutButton.setTitle("Record new workout", for: .normal)
        postWorkoutButton.addTarget(self, action: #selector(ChartViewController.postButtonPressed), for: UIControlEvents.touchUpInside)
        postWorkoutButton.setTitleColor(UIColor.themeLightBlue, for: .normal)
        postWorkoutButton.titleLabel?.font = UIFont(name: "Optima-ExtraBlack", size: 20)
    }
    
    func postButtonPressed() {
        performSegue(withIdentifier: "postWorkout", sender: self)
    }
    
    // Populate data
    func populateChartData() {
        
        DataModel.sharedInstance.fetchWorkoutData()
        workouts = DataModel.sharedInstance.workouts
        
        for workout in workouts {
            guard let mile = workout.mileage else { return }
            miles.append(mile)
        }
        
        workoutDuration = ["1","2","3","4","5","6","7","8","9","10"]
        beatsPerMinute = ["100","120","100","40","100","90","70","100","90","100"]
        milesWorkoutDuration = ["11","21","31","41","51","61","71","81","91","101"]
        milesBeatsPerMinute = ["100","120","100","40","100","90","70","100","90","100"]
        print("MILES: \(miles)")
    }
    
    // Bar chart config
    func barChartConfig() {
        self.chartContainerView.addSubview(barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 400).isActive = true
        barChart.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor, constant: -20).isActive = true
        barChart.topAnchor.constraint(equalTo: chartContainerView.topAnchor, constant: 0).isActive = true
        barChart.centerXAnchor.constraint(equalTo: chartContainerView.centerXAnchor).isActive = true
        barChart.delegate = self
    }
    
    // Conform to protocol
    func getChartData(with dataPoints: [String], values: [String], legend: String) {
        self.workoutDuration = dataPoints
        self.beatsPerMinute = values
        self.milesWorkoutDuration = dataPoints
        self.milesBeatsPerMinute = values
        self.legend = legend
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postWorkout" {
            let dest = segue.destination as! AddDataViewController
        }
    }
}

// MARK: - ChartFormatter required to config xaxis
public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    var workoutDuration = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return workoutDuration[Int(value)]
    }
    
    public func setValues(values: [String]) {
        self.workoutDuration = values
    }
}
