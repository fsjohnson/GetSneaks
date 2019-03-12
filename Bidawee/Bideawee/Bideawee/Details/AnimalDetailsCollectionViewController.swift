//
//  AnimalDetailsCollectionViewController.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

private struct Layout {
    static let cellPadding: CGFloat = 5
    static let cellHeight: CGFloat = 120
    static let detailTopViewHeight: CGFloat = 170
}

enum AnimalSections: Int {
    case speciesBreed, ageSex, sizeColor
    
    var rows: [AnimalRows] {
        switch self {
        case .speciesBreed:
            return [.species, .breed]
        case .ageSex:
            return [.age, .sex]
        case .sizeColor:
            return [.size, .color]
        }
    }
}

enum AnimalRows {
    case species, breed, age, sex, size, color, count
}

class AnimalDetailsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Private properties
    private let scrollView = UIScrollView()
    private let detailTopView = DetailTopView()
    private let descriptionLabel = UILabel()
    private let collectionView: UICollectionView
    private let animalSections: [AnimalSections] = [.speciesBreed, .ageSex, .sizeColor]
    
    //MARK: - Public properties
    let animal: Animal
    
    // TODO - init with animal
    init(animal: Animal) {
        self.animal = animal
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.scrollDirection         = .vertical
        flowLayout.minimumLineSpacing      = 0
        collectionView                     = UICollectionView(frame: .zero, collectionViewLayout:flowLayout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let detailTopViewHeight = detailTopView.bounds.height
        let descriptionLabelHeight = descriptionLabel.bounds.height
        let collectionViewHeight = collectionView.bounds.height
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 40 + detailTopViewHeight + descriptionLabelHeight + collectionViewHeight)
    }
    
    private func setUpView() {
        
        title =  "Leo"
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false 
        
        collectionView.register(AnimalDetailCollectionViewCell.self, forCellWithReuseIdentifier: "detailCell")
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.addSubview(detailTopView)
        detailTopView.imageName = animal.imageLink
        detailTopView.translatesAutoresizingMaskIntoConstraints = false
        detailTopView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        detailTopView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 10).isActive = true
        detailTopView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        detailTopView.heightAnchor.constraint(equalToConstant: Layout.detailTopViewHeight).isActive = true
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.themeSmallRegular
        descriptionLabel.text = animal.description
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: detailTopView.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -5).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cvWidth = collectionView.frame.size.width - (2 * Layout.cellPadding)
        return CGSize(width: cvWidth/2, height: Layout.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(Layout.cellPadding), left: 0, bottom: CGFloat(Layout.cellPadding), right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return animalSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalSections[section].rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let animalSections = self.animalSections[indexPath.section]
        let row = animalSections.rows[indexPath.row]
        
        let cell: AnimalDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! AnimalDetailCollectionViewCell
        
        switch row {
        case .species:
            cell.titleLabel.text = "Species"
            cell.detailsLabel.text = animal.species?.capitalized
            
        case .breed:
            cell.titleLabel.text = "Breed"
            cell.detailsLabel.text = animal.breed?.capitalized
            
        case .age:
            cell.titleLabel.text = "Age"
            cell.detailsLabel.text = animal.age ?? "N/A"
            
        case .sex:
            cell.titleLabel.text = "Sex"
            cell.detailsLabel.text = animal.sex?.capitalized
            
        case .size:
            cell.titleLabel.text = "Size"
            cell.detailsLabel.text = animal.size?.capitalized
            
        case .color:
            cell.titleLabel.text = "Color"
            cell.detailsLabel.text = animal.colors?.joined(separator: ",").capitalized
            
        default:
            break

        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0

        return cell
    }
    
}
