//
//  InitialView.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class InitialView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Memories!"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Click the \"Select memories\" button below to get started. \n\nAfter you have selected the images you want to display, you will be prompted to finalize the image order. \n\nYou will then be given the option to add music using your Spotify account. \n\nFinally, you can send this awesome slideshow of memories to Facebook! \n\nHave fun!"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var selectImagesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select memories", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private func configLayout() {
        // Welcome label config
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Instructions label config
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(instructionsLabel)
        instructionsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        instructionsLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // Button config
        selectImagesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectImagesButton)
        selectImagesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        selectImagesButton.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 20).isActive = true
        selectImagesButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectImagesButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
