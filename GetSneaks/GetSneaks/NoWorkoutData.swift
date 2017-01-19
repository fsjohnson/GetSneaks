//
//  NoWorkoutData.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/18/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class NoWorkoutData: UIView {
    
    var noDataLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLayout() {
        // background config
        self.backgroundColor = UIColor.themeMediumBlue
        
        // label config
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noDataLabel)
        noDataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        noDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        noDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        noDataLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont(name: "Optima-ExtraBlack", size: 15)
        noDataLabel.textColor = UIColor.themeLightGreen
        noDataLabel.text = "Here's where your workout history will be shown! Record your workouts below and watch the charts grow!"
        noDataLabel.numberOfLines = 0
        noDataLabel.lineBreakMode = .byWordWrapping
    }
}
