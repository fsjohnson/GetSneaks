//
//  AnimalDetailCollectionViewCell.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

private struct Layout {
    static let titleLabelWidthOffset: CGFloat = 0.9
    static let titleLabelHeight: CGFloat = 20
}

class AnimalDetailCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let detailsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error in AnimalDetailView")
    }
    
    private func setUpView() {
        addSubview(titleLabel)
        addSubview(detailsLabel)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.themeSmallBold
        titleLabel.textColor = .themePink
        detailsLabel.textAlignment = .center
        detailsLabel.lineBreakMode = .byWordWrapping
        detailsLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Layout.titleLabelWidthOffset).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Layout.titleLabelHeight).isActive = true
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        detailsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Layout.titleLabelWidthOffset).isActive = true
        detailsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
