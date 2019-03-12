//
//  AnimalTableViewCell.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/17/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

private struct Layout {
    static let animalPicWidthHeight: CGFloat = 200.0
}

class AnimalTableViewCell: UITableViewCell {
    
    var animalPic = UIImageView()
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error in AnimalTableViewCell")
    }
    
    func setUpView() {
        self.isUserInteractionEnabled = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.selectionStyle = .none
        
        addSubview(animalPic)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
        animalPic.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.themeLargeBold
        nameLabel.textColor = UIColor.themePink
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        animalPic.translatesAutoresizingMaskIntoConstraints = false
        animalPic.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animalPic.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        animalPic.widthAnchor.constraint(equalToConstant: Layout.animalPicWidthHeight).isActive = true
        animalPic.heightAnchor.constraint(equalToConstant: Layout.animalPicWidthHeight).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: animalPic.bottomAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
