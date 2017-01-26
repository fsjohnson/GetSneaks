//
//  OldSneaksTableViewCell.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class OldSneaksTableViewCell: UITableViewCell {
    
    var topLabel = UILabel()
    var barChart: BarChart!
    var totalMiles = UILabel()
    var totalCals = UILabel()
    var totalMinutes = UILabel()
    var stackView = UIStackView()
    var noWorkoutData = NoWorkoutData()
    
    var workout: WorkoutData? {
        didSet {
            configCell()
            guard let mile = workout?.mileage else { print("error retrieving mile"); return }
            guard let cals = workout?.calorie else { print("error retrieving cals"); return }
            guard let mins = workout?.minute else { print("error retrieving mins"); return }
            guard let dates = workout?.workoutDate else { print("error retrieving dates"); return }
            configMilesLabel(with: mile)
            configCalsLabel(with: cals)
            configMinsLabel(with: mins)
            topLabelConfig(with: dates)
        }
    }
    
    private func configCell() {
        // background color
        self.backgroundColor = UIColor.themeMediumBlue
        
        // top label config
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topLabel)
        topLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        topLabel.font = UIFont(name: "Optima-Bold", size: 15.0)
        topLabel.textColor = UIColor.white
        topLabel.textAlignment = .center
        
        // bar chart config
        barChart = BarChart()
        barChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(barChart)
        barChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        barChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        barChart.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 3).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        // totalMiles config
        totalMiles.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalMiles)
        totalMiles.heightAnchor.constraint(equalToConstant: 15).isActive = true
        totalMiles.font = UIFont(name: "Optima-Bold", size: 12.0)
        totalMiles.textColor = UIColor.white
        totalMiles.textAlignment = .center
        
        // totalCals config
        totalCals.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalCals)
        totalCals.heightAnchor.constraint(equalToConstant: 15).isActive = true
        totalCals.font = UIFont(name: "Optima-Bold", size: 12.0)
        totalCals.textColor = UIColor.white
        totalCals.textAlignment = .center
        
        // totalMinutes config
        totalMinutes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalMinutes)
        totalMinutes.heightAnchor.constraint(equalToConstant: 15).isActive = true
        totalMinutes.font = UIFont(name: "Optima-Bold", size: 12.0)
        totalMinutes.textColor = UIColor.white
        totalMinutes.textAlignment = .center
        
        // stack view config
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(totalMiles)
        stackView.addArrangedSubview(totalCals)
        stackView.addArrangedSubview(totalMinutes)
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: barChart.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

extension OldSneaksTableViewCell {
    func topLabelConfig(with dates: [String]) {
        guard let firstDate = dates.first else { print("error retrieving first date"); return }
        guard let lastDate = dates.last else { print("error retrieving first date"); return }
        topLabel.text = "Workout stats from \(firstDate) - \(lastDate)"
    }
    
    func configMilesLabel(with miles: [String]) {
        var totalMilesCount = 0
        for mile in miles {
            guard let mileInt = Int(mile) else { print("error casting mile as int"); return }
            totalMilesCount += mileInt
        }
        print("Total miles: \(totalMilesCount)")
        totalMiles.text = "Total miles: \(totalMilesCount)"
    }
    
    func configCalsLabel(with calories: [String]) {
        var totalCalsCount = 0
        for cal in calories {
            guard let calInt = Int(cal) else { print("error casting cal as int"); return }
            totalCalsCount += calInt
        }
        print("Total calories: \(totalCalsCount)")
        totalCals.text = "Total calories: \(totalCalsCount)"
    }
    
    func configMinsLabel(with minutes: [String]) {
        var totalMinsCount = 0
        for min in minutes {
            guard let minInt = Int(min) else { print("error casting min as int"); return }
            totalMinsCount += minInt
        }
        print("Total minutes: \(totalMinsCount)")
        totalMinutes.text = "Total minutes: \(totalMinsCount)"
    }
}
