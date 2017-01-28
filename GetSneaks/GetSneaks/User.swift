//
//  User.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

class User {
    var name: String
    var email: String
    var previousWorkoutData: [WorkoutData]?
    var gender: String
    var age: Int
    var height: Double
    var weight: Double
    
    init(name: String, email: String, gender: String, age: Int, height: Double, weight: Double) {
        self.name = name
        self.email = email
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
    }
}
