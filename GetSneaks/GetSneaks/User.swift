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
    var weight: Double
    
    init(name: String, email: String, weight: Double) {
        self.name = name
        self.email = email
        self.weight = weight
    }
}
