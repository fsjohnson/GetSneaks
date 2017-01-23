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
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
