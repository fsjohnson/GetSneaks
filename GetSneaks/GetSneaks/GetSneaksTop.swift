//
//  GetSneaksTop.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/13/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class GetSneaksTop: UIView {

    var getSneaksLabel = UILabel()
    var milesCompletedTextLabel = UILabel()
    var milesCompletedIntLabel = UILabel()
    var milesLeftTextLabel = UILabel()
    var milesLeftIntLabel = UILabel()
    var historyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        populateMilesCompleted()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        // getSneaks label config
        getSneaksLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(getSneaksLabel)
        getSneaksLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        getSneaksLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        getSneaksLabel.text = "getSneaks?"
        getSneaksLabel.font = UIFont(name: "Optima-ExtraBlack", size: 40)
        getSneaksLabel.textColor = UIColor.themeLightBlue
        
        // miles completed labels
        milesCompletedTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesCompletedTextLabel)
        milesCompletedTextLabel.topAnchor.constraint(equalTo: getSneaksLabel.bottomAnchor, constant: 8).isActive = true
        milesCompletedTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        milesCompletedTextLabel.text = "Miles completed in current sneaks:"
        milesCompletedTextLabel.textColor = UIColor.white
        milesCompletedTextLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        milesCompletedIntLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesCompletedIntLabel)
        milesCompletedIntLabel.topAnchor.constraint(equalTo: getSneaksLabel.bottomAnchor, constant: 8).isActive = true
        milesCompletedIntLabel.leadingAnchor.constraint(equalTo: milesCompletedTextLabel.trailingAnchor, constant: 8).isActive = true
        milesCompletedIntLabel.textColor = UIColor.white
        milesCompletedIntLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        // miles left label
        milesLeftTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesLeftTextLabel)
        milesLeftTextLabel.topAnchor.constraint(equalTo: milesCompletedTextLabel.bottomAnchor, constant: 8).isActive = true
        milesLeftTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        milesLeftTextLabel.text = "Miles left in current sneaks:"
        milesLeftTextLabel.textColor = UIColor.white
        milesLeftTextLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        milesLeftIntLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesLeftIntLabel)
        milesLeftIntLabel.topAnchor.constraint(equalTo: milesCompletedIntLabel.bottomAnchor, constant: 8).isActive = true
        milesLeftIntLabel.leadingAnchor.constraint(equalTo: milesLeftTextLabel.trailingAnchor, constant: 8).isActive = true
        milesLeftIntLabel.textColor = UIColor.white
        milesLeftIntLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        // History label
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(historyLabel)
        historyLabel.topAnchor.constraint(equalTo: milesLeftTextLabel.bottomAnchor, constant: 15).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        historyLabel.text = "Workout History"
        historyLabel.backgroundColor = UIColor.themeMediumBlue
        historyLabel.font = UIFont(name: "Optima-ExtraBlack", size: 25)
        historyLabel.textColor = UIColor.themeLightBlue
    }
}

extension GetSneaksTop {
    fileprivate func populateMilesCompleted() {
        var totalMileage = 0
        DataModel.sharedInstance.fetchWorkoutData()
        for item in DataModel.sharedInstance.workouts {
            guard let mile = item.mileage else { print("error retrieving core data miles"); return }
            guard let doubleMile = Int(mile) else { print("problem casting core data mile as int"); return }
            totalMileage += doubleMile
        }
        milesCompletedIntLabel.text = "\(totalMileage) mi"
        populateMilesLeft(from: totalMileage)
    }
    
    private func populateMilesLeft(from completedMiles: Int) {
        let milesLeft = 400 - completedMiles
        milesLeftIntLabel.text = "\(milesLeft) mi"
    }
}
