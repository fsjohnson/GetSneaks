//
//  ResultsTableViewController.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/17/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

enum VCType {
    case results, favorites
}

class ResultsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Private properties
    private let tableView = UITableView()
    private var animals = [Animal]()
    private let vcType: VCType
    
    init(vcType: VCType) {
        self.vcType = vcType
        super.init(nibName: nil, bundle: nil)
        
        switch vcType {
        case .results:
            title = "Results"
        case .favorites:
            title = "Favorites"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error loading ResultsCollectionViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        //TODO - remove once can use CD / server
        let leo = Animal(type: "cat", species: "cat", colors: ["White", "Grey"], sex: "Male", breed: "Domestic Shorthair, Mix", name: "Leo", imageLink: "leo", age: "1 yr 6 mos", size: "M", description: "Loving and kind, Leo is as gentle as it gets. Leo is a one year old male Domestic Shorthair with an exotic look. Leo has a long and illustrious face with big ears. At 11 pounds, he's on the larger side, which just adds to his intriguing appearance. Leo is a wonderful cat, although he can be slightly timid at first. But with a few scratches behind the ears and some sweet words, Leo begins to open up. He'll lean into your hand for more pets and you'll begin to hear a low purr come from his body. Leo is also big fan of scratches on the back, as you can tell from the way his behind begins to rise high in the air. Leo gets along great with other cats and would be a wonderful companion if you already have a feline. If this gentle soul seems like the one for you, come adopt Leo today!")
        
        let josephine = Animal(type: "cat", species: "cat", colors: ["Grey", "Orange"], sex: "Female", breed: "Domestic Shorthair, Mix", name: "Josephine", imageLink: "catPic", age: "0 yr 5 mos", size: "S", description: "This charming dilute calico is Josephine. Josephine is a five month old Domestic Shorthair mix who arrived at Bideawee in early September. Josephine has a beautiful orange and grey coat with warm amber eyes. She is a loving and sweet cat, although she's quite shy at first. Josephine can become nervous around new people and in new areas so she's hoping for an understanding and committed owner. Someone who realizes that with time and patience, she'll come out of her shell and bond to them with all her heart. Josephine gets along with other cats and they help her come out of her shell. To meet Josephine, come to Bideawee!")
        
        animals.append(leo)
        animals.append(josephine)
    }
    
    func setUpView() {

        view.backgroundColor = .white
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 370
        tableView.isUserInteractionEnabled = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    // MARK: UITableViewDataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! AnimalTableViewCell
        
        if let imageName = animals[indexPath.item].imageLink {
            
            cell.animalPic.image = UIImage(imageLiteralResourceName: imageName)
        }
        
        cell.nameLabel.text = animals[indexPath.item].name
        cell.descriptionLabel.text = animals[indexPath.item].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animals[indexPath.row]
        let vc = AnimalDetailsCollectionViewController(animal: animal)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
