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

protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String])
    var workoutDuration: [String] {get set}
    var beatsPerMinute: [String] {get set}
}

class ChartViewController: UIViewController, GetChartData {

    // Chart data
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate chart data
        populateChartData()
        
        // Bar chart
        //barChart()

        // Line chart
        //lineChart()

        // Cubic line chart
        cubicChart()
    }
    
    // Populate data
    func populateChartData() {
        workoutDuration = ["1","2","3","4","5","6","7","8","9","10"]
        beatsPerMinute = ["76","150", "160", "180", "195", "195", "180", "164", "136", "112"]
        self.getChartData(with: workoutDuration, values: beatsPerMinute)
    }
    
    // Chart options 
    
    func barChart() {
        let barChart = BarChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
        barChart.delegate = self
        self.view.addSubview(barChart)
    }
    
    func lineChart() {
        let lineChart = LineChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
        lineChart.delegate = self
        self.view.addSubview(lineChart)
    }
    
    func cubicChart() {
        let cubicChart = CubicChart(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height))
        cubicChart.delegate = self
        self.view.addSubview(cubicChart)
    }
    
    // Conform to protocol
    func getChartData(with dataPoints: [String], values: [String]) {
        self.workoutDuration = dataPoints
        self.beatsPerMinute = values
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
