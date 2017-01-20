//
//  OldSneaksTableViewCell.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class OldSneaksTableViewCell: UITableViewCell {
    
    var barChart: BarChart!
    var totalMiles = UILabel()
    var totalCals = UILabel()
    var totalMinutes = UILabel()
    var stackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }
    
    private func configCell() {
        print("TABLE CELL CONFIG")
        // background color
        self.backgroundColor = UIColor.themeMediumBlue
        
        // bar chart config
        barChart = BarChart()
        barChart.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(barChart)
        barChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        barChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        barChart.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // totalMiles config
        totalMiles.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalMiles)
        totalMiles.heightAnchor.constraint(equalToConstant: 25).isActive = true
        totalMiles.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalMiles.font = UIFont(name: "Optima-Bold", size: 15.0)
        totalMiles.text = "Miles:"
        totalMiles.textColor = UIColor.white
        totalMiles.textAlignment = .center
        totalMiles.text = "Total miles: "
        
        // totalCals config
        totalCals.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalCals)
        totalCals.heightAnchor.constraint(equalToConstant: 25).isActive = true
        totalCals.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalCals.font = UIFont(name: "Optima-Bold", size: 15.0)
        totalCals.text = "Miles:"
        totalCals.textColor = UIColor.white
        totalCals.textAlignment = .center
        totalCals.text = "Total calories: "
        
        // totalMinutes config
        totalMinutes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalMinutes)
        totalMinutes.heightAnchor.constraint(equalToConstant: 25).isActive = true
        totalMinutes.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalMinutes.font = UIFont(name: "Optima-Bold", size: 12.0)
        totalMinutes.text = "Miles:"
        totalMinutes.textColor = UIColor.white
        totalMinutes.textAlignment = .center
        totalMinutes.text = "Total minutes: "

        // stack view config
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(totalMiles)
        stackView.addArrangedSubview(totalCals)
        stackView.addArrangedSubview(totalMinutes)
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: barChart.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
