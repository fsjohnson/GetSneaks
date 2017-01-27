
//
//  FirebaseMethods.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/22/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseMethods {
    
    //MARK: - Sign Up & Log In funcs
    static func signInButton(email: String, password: String, completion: @escaping (Bool) -> () ) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func signUpButton(email: String, password: String, name: String, age: String, gender: String, height: String, weight: String, completion: @escaping (Bool) -> () ) {
        let ref = FIRDatabase.database().reference().root
        var boolToPass = false
        
        if email != "" && password != "" {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    let userDictionary = ["email": email, "name": name, "gender": gender, "age": age, "height": height, "weight": weight]
                    
                    ref.child("users").child((user?.uid)!).setValue(userDictionary)
                    boolToPass = true
                    completion(boolToPass)
                    
                } else {
                    print(error?.localizedDescription ?? "")
                    boolToPass = false
                    completion(boolToPass)
                }
            })
        }
    }
    
    // MARK: - Send workout data to firebase 
    
    static func sendPreviousWorkoutData(with previousWorkouts: [Workout]) {
        guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("users").child(currentUser).child("previousWorkouts")
        let workoutID = FIRDatabase.database().reference().childByAutoId().key
        var miles = [String]()
        var dates = [String]()
        var calories = [String]()
        var minutes = [String]()
        
        // Today's date config
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YY"
        let dateToSave = dateFormatter.string(from: date)
        
        for workout in previousWorkouts {
            guard let mile = workout.mileage else { print("error sending miles"); return }
            guard let minute = workout.minute else { print("error sending minute"); return }
            guard let calorie = workout.calorie else { print("error sending calorie"); return }
            guard let date = workout.workoutDate else { print("error sending date"); return }
            miles.append(mile)
            minutes.append(minute)
            calories.append(calorie)
            dates.append(date)
        }
        ref.updateChildValues([workoutID: ["miles": miles, "dates": dates, "dateNewSneaks": dateToSave, "calories" : calories, "minutes": minutes]])
    }
    
    // MARK: - Retrieve workout data 
    static func retrievePreviousWorkouts(with completion: @escaping ([WorkoutData]) -> Void) {
        guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("users").child(currentUser).child("previousWorkouts")
        var previousWorkouts = [WorkoutData]()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChildren() {
                print("no previous workout data")
            } else {
                guard let snapshotValue = snapshot.value as? [String: Any] else { return }
                for snap in snapshotValue {
                    guard
                        let workoutInfo = snap.value as? [String: Any],
                        let miles = workoutInfo["miles"] as? [String],
                        let calories = workoutInfo["calories"] as? [String],
                        let minutes = workoutInfo["minutes"] as? [String],
                        let dates = workoutInfo["dates"] as? [String],
                        let dateNewSneaks = workoutInfo["dateNewSneaks"] as? String
                        else { print("error retriving previous workouts from firebase"); return }
                    let previousWorkout = WorkoutData(mileage: miles, calorie: calories, workoutDate: dates, minute: minutes, newSneaksDate: dateNewSneaks)
                    previousWorkouts.append(previousWorkout)
                    if previousWorkouts.count == snapshotValue.count {
                        previousWorkouts.sort(by: { (workoutOne, workoutTwo) -> Bool in
                            workoutOne.newSneaksDate > workoutTwo.newSneaksDate
                        })
                        completion(previousWorkouts)
                    }
                }
            }
        })
    }
    
    // MARK: - Retrieve user 
    static func retrieveCurrentUserInfo(with completion: @escaping (User?) -> Void) {
        guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("users").child(currentUser)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChildren() {
                print("no previous workout data")
                completion(nil)
            } else {
                guard let snapshotValue = snapshot.value as? [String: Any] else { return }
                guard
                    let name = snapshotValue["name"] as? String,
                    let gender = snapshotValue["gender"] as? String,
                    let email = snapshotValue["email"] as? String,
                    let age = snapshotValue["age"] as? String,
                    let intAge = Int(age),
                    let height = snapshotValue["height"] as? String,
                    let intHeight = Int(height),
                    let weight = snapshotValue["weight"] as? String,
                    let intWeight = Int(weight)
                    else { print("error retrieving current user info"); return }
                let currentUser = User(name: name, email: email, gender: gender, age: intAge, height: intHeight, weight: intWeight)
                completion(currentUser)
            }
        })
    }
}
