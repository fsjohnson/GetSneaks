//
//  Workout.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

class WorkoutData {
    var mileage: [String]
    var calorie: [String]
    var workoutDate: [String]
    var minute: [String]
    var newSneaksDate: String
    
    init(mileage: [String], calorie: [String], workoutDate: [String], minute: [String], newSneaksDate: String) {
        self.mileage = mileage
        self.calorie = calorie
        self.workoutDate = workoutDate
        self.minute = minute
        self.newSneaksDate = newSneaksDate
    }
}
