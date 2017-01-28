//
//  OldSneaksTableViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class OldSneaksTableViewController: UITableViewController, GetChartData {
    
    var workoutData = [WorkoutData]()
    var newSneaksDates = String()
    var workoutDuration = [String]()
    var calories = [String]()
    var dates = [String]()
    var miles = [String]()
    var legend = String()
    var noWorkoutData = NoWorkoutData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPreviousWorkouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPreviousWorkouts()
    }
    
    // Fetch data
    func fetchPreviousWorkouts() {
        FirebaseMethods.checkIfPreviousWorkoutsIsEmpty { (isEmpty) in
            if isEmpty == true {
                self.configNoWorkoutData()
            } else {
                FirebaseMethods.retrievePreviousWorkouts { (savedWorkoutData) in
                    if self.view.subviews.contains(self.noWorkoutData) {
                        self.noWorkoutData.removeFromSuperview()
                    }
                    self.workoutData = savedWorkoutData
                    self.tableView.reloadData()
                }
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
    
    // No workout data
    func configNoWorkoutData() {
        self.view.addSubview(noWorkoutData)
        noWorkoutData.translatesAutoresizingMaskIntoConstraints = false
        noWorkoutData.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        noWorkoutData.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        noWorkoutData.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        noWorkoutData.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        noWorkoutData.noDataLabel.text = "Every time you hit 400 mi in your sneaks your workout history in those sneaks will show up here!"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldSneak", for: indexPath) as! OldSneaksTableViewCell
        getChartData(with: workoutData[indexPath.row].workoutDate, values: workoutData[indexPath.row].mileage, legend: "Miles")
        cell.workout = workoutData[indexPath.row]
        cell.barChart.delegate = self
        cell.barChart.barChartView.legend.enabled = true
        cell.barChart.barChartView.legend.font = UIFont(name: "Optima-Bold", size: 11)!
        cell.barChart.barChartView.legend.textColor = UIColor.white
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if workoutData.count == 1 {
            return self.view.frame.height
        } else {
            return 300.0
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
