//
//  SearchViewController.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/9/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    private struct Layout {
        static let subViewHeight: CGFloat = 80
        static let buttonHeight: CGFloat = 50
        static let scrollViewHeight: CGFloat = 620
    }

    private let scrollView = UIScrollView()
    private let petSubView = SearchSubView(data: ["All", "Cat", "Dog"])
    private let genderSubView = SearchSubView(data: ["All","Female", "Male"])
    private let ageSubView = SearchSubView(data: ["All","< 1 yr", "> 1 yr"])
    private let locationSubView = SearchSubView(data: ["All","Manhattan", "New Arrivals", "Westhampton"])
    private let sortSubView = SearchSubView(data: ["All","Breed", "Gender", "Name"])
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: Layout.scrollViewHeight)
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        title = "Search"
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont.themeMediumBold
        searchButton.titleLabel?.textColor = .white
        searchButton.backgroundColor = .black
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.borderColor = UIColor.black.cgColor
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        petSubView.title = "Pets:"
        genderSubView.title = "Gender:"
        ageSubView.title = "Age:"
        locationSubView.title = "Location:"
        sortSubView.title = "Sort By:"
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.addSubview(petSubView)
        petSubView.translatesAutoresizingMaskIntoConstraints = false
        petSubView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        petSubView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        petSubView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.75).isActive = true
        petSubView.heightAnchor.constraint(equalToConstant: Layout.subViewHeight).isActive = true

        scrollView.addSubview(genderSubView)
        genderSubView.translatesAutoresizingMaskIntoConstraints = false
        genderSubView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        genderSubView.topAnchor.constraint(equalTo: petSubView.bottomAnchor, constant: 20).isActive = true
        genderSubView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.75).isActive = true
        genderSubView.heightAnchor.constraint(equalToConstant: Layout.subViewHeight).isActive = true
        
        scrollView.addSubview(ageSubView)
        ageSubView.translatesAutoresizingMaskIntoConstraints = false
        ageSubView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        ageSubView.topAnchor.constraint(equalTo: genderSubView.bottomAnchor, constant: 20).isActive = true
        ageSubView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.75).isActive = true
        ageSubView.heightAnchor.constraint(equalToConstant: Layout.subViewHeight).isActive = true
        
        scrollView.addSubview(locationSubView)
        locationSubView.translatesAutoresizingMaskIntoConstraints = false
        locationSubView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationSubView.topAnchor.constraint(equalTo: ageSubView.bottomAnchor, constant: 20).isActive = true
        locationSubView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.75).isActive = true
        locationSubView.heightAnchor.constraint(equalToConstant: Layout.subViewHeight).isActive = true
        
        scrollView.addSubview(sortSubView)
        sortSubView.translatesAutoresizingMaskIntoConstraints = false
        sortSubView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sortSubView.topAnchor.constraint(equalTo: locationSubView.bottomAnchor, constant: 20).isActive = true
        sortSubView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.75).isActive = true
        sortSubView.heightAnchor.constraint(equalToConstant: Layout.subViewHeight).isActive = true
        
        scrollView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        searchButton.topAnchor.constraint(equalTo: sortSubView.bottomAnchor, constant: 20).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
    }
    
    func searchButtonClicked() {
        let vc = ResultsTableViewController(vcType: .results)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
