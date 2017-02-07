//
//  ImageCollectionViewCell.swift
//  Memories
//
//  Created by Felicity Johnson on 2/7/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("config cell")
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cellImageView: UIImageView = {
       return UIImageView()
    }()
    
    private func configCell() {
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        self.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        cellImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        cellImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cellImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}
