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
    func getChartData(with dataPoints: [String], values: [String])
    var workoutDuration: [String] {get set}
    var beatsPerMinute: [String] {get set}
}

class ChartViewController: UIViewController, GetChartData {

    // Views
    var historyLabel = UILabel()
    var getSneaksTop: GetSneaksTop!
    
    // Chart data
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    var miles = [String]()
    var workouts = [Workout]()
    var chartScrollView: UIScrollView!
    
    // Post Workout
    var postWorkoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config view
        configLayout()
        
        // Populate chart data
        populateChartData()
        
        // Bar chart
        //barChart()

        // Line chart
        //lineChart()

        // Cubic line chart
        cubicChart()
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
        getSneaksTop.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // History label
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(historyLabel)
        historyLabel.topAnchor.constraint(equalTo: getSneaksTop.bottomAnchor, constant: 8).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        historyLabel.text = "Workout History"
        
        // Scroll view for charts 
                
        // Segmented control
        
        // Post workout button
        postWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(postWorkoutButton)
        postWorkoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        postWorkoutButton.topAnchor.constraint(equalTo: cubicChart.bottomAnchor, constant: 8).isActive = true
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
        print("MILES: \(miles)")
        self.getChartData(with: workoutDuration, values: beatsPerMinute)
    }
    
    // Chart options
    func barChart() {
        let barChart = BarChart()
        self.view.addSubview(barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 400).isActive = true
        barChart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        barChart.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        barChart.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 8).isActive = true
        barChart.delegate = self
    }
    
    func lineChart() {
        let lineChart = LineChart()
        self.view.addSubview(lineChart)
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.heightAnchor.constraint(equalToConstant: 400).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        lineChart.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func cubicChart() {
        let cubicChart = CubicChart()
        self.view.addSubview(cubicChart)
        cubicChart.translatesAutoresizingMaskIntoConstraints = false
        cubicChart.heightAnchor.constraint(equalToConstant: 400).isActive = true
        cubicChart.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        cubicChart.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        cubicChart.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 8).isActive = true
        cubicChart.delegate = self
    }
    
    // Conform to protocol
    func getChartData(with dataPoints: [String], values: [String]) {
        self.workoutDuration = dataPoints
        self.beatsPerMinute = values
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
