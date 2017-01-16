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
    var milesCompletedLabel = UILabel()
    var milesLeftLabel = UILabel()
    var historyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
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
        
        // miles completed label
        milesCompletedLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesCompletedLabel)
        milesCompletedLabel.topAnchor.constraint(equalTo: getSneaksLabel.bottomAnchor, constant: 8).isActive = true
        milesCompletedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        milesCompletedLabel.text = "Miles completed in current sneaks:"
        milesCompletedLabel.textColor = UIColor.white
        milesCompletedLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        // miles left label
        milesLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(milesLeftLabel)
        milesLeftLabel.topAnchor.constraint(equalTo: milesCompletedLabel.bottomAnchor, constant: 8).isActive = true
        milesLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        milesLeftLabel.text = "Miles left in current sneaks:"
        milesLeftLabel.textColor = UIColor.white
        milesLeftLabel.font = UIFont(name: "Optima-Bold", size: 15)
        
        // History label
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(historyLabel)
        historyLabel.topAnchor.constraint(equalTo: milesLeftLabel.bottomAnchor, constant: 15).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        historyLabel.text = "Workout History"
        historyLabel.backgroundColor = UIColor.themeMediumBlue
        historyLabel.font = UIFont(name: "Optima-ExtraBlack", size: 25)
        historyLabel.textColor = UIColor.themeLightBlue
    }
}
