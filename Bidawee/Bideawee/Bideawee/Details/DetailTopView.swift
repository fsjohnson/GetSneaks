//
//  DetailTopView.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/24/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

private struct Layout {
    static let imageViewWidthHeight: CGFloat = 160
    static let starImageViewWidthHeight: CGFloat = 70
}

class DetailTopView: UIView {
    
    //MARK: - Private properties
    private let animalImageView = UIImageView()
    private let starImageViewButton = UIButton()
    private var starImage: UIImage?
    
    //MARK: - Public properties

    // TODO base this off of CD property
    var isStarred = false {
        didSet {
            starImage = isStarred ? UIImage(named: "openStar") : UIImage(named: "fullStar")
            starImageViewButton.setImage(starImage, for: .normal)
        }
    }
    
    var imageName: String? {
        didSet {
            let name = imageName ?? "Bideawee"
            animalImageView.image = UIImage(named: name)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(animalImageView)
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        animalImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animalImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        animalImageView.widthAnchor.constraint(equalToConstant: Layout.imageViewWidthHeight).isActive = true
        animalImageView.heightAnchor.constraint(equalToConstant: Layout.imageViewWidthHeight).isActive = true
        animalImageView.layer.cornerRadius = Layout.imageViewWidthHeight/2.0
        animalImageView.clipsToBounds = true
        
        starImage = isStarred ? UIImage(named: "fullStar") : UIImage(named: "openStar")
        starImageViewButton.setImage(starImage, for: .normal)
        starImageViewButton.addTarget(self, action: #selector(unfavoriteAnimal), for: .touchUpInside)
        
        addSubview(starImageViewButton)
        starImageViewButton.translatesAutoresizingMaskIntoConstraints = false
        starImageViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        starImageViewButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        starImageViewButton.widthAnchor.constraint(equalToConstant: Layout.starImageViewWidthHeight).isActive = true
        starImageViewButton.heightAnchor.constraint(equalToConstant: Layout.starImageViewWidthHeight).isActive = true
    }
    
    func unfavoriteAnimal() {
        if isStarred {
            isStarred = false
        } else {
            isStarred = true
        }
    }
}
