//
//  AnimalModel.swift
//  Bideawee
//
//  Created by Felicity Johnson on 9/17/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct Animal {
    let type: String?
    let species: String?
    let colors: [String]?
    let sex: String?
    let breed: String?
    let name: String?
    let imageLink: String?
    let age: String?
    let size: String?
    let description: String?
    let uniqueID: String = ""
    
    init(dict: [String:Any]) {
        self.type = dict["animal"] as? String
        self.species = dict["species"] as? String
        self.colors = dict["colors"] as? [String]
        self.sex = dict["sex"] as? String
        self.age = dict["age"] as? String
        self.size = dict["size"] as? String
        self.breed = dict["breeds"] as? String
        self.name = dict["name"] as? String
        self.imageLink = dict["media"] as? String
        self.description = dict["description"] as? String
    }
    
    init(type: String, species: String, colors: [String], sex: String, breed: String, name: String, imageLink: String, age: String, size: String, description: String) {
        self.type = type
        self.species = species
        self.colors = colors
        self.sex = sex
        self.breed = breed
        self.name = name
        self.imageLink = imageLink
        self.age = age
        self.size = size
        self.description = description
    }
}
