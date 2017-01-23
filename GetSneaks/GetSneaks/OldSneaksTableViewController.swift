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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPreviousWorkouts()
        print("WORKOUT COUNT: \(workoutData.count)")
    }
    
    // Fetch data
    func fetchPreviousWorkouts() {
        FirebaseMethods.retrievePreviousWorkouts { (savedWorkoutData) in
            self.workoutData = savedWorkoutData
        }
        for item in workoutData {
            print("WORKOUT DATA: \(item)")
            //getChartData(with: item.workoutDate, values: item.mileage, legend: "Miles")
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
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldSneak", for: indexPath) as! OldSneaksTableViewCell
        cell.barChart.delegate = self
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
