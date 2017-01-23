
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
    
    static func signUpButton(email: String, password: String, name: String, username: String, completion: @escaping (Bool) -> () ) {
        let ref = FIRDatabase.database().reference().root
        var boolToPass = false
        
        if email != "" && password != "" {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    let userDictionary = ["email": email, "name": name]
                    
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
    
    static func sendPreviousWorkoutData(with previousWorkout: WorkoutData) {
        guard let currentUser = FIRAuth.auth()?.currentUser?.uid else { return }
        let ref = FIRDatabase.database().reference().child("users").child(currentUser).child("previousWorkouts")
        let workoutID = FIRDatabase.database().reference().childByAutoId()
        
        print("miles : \(previousWorkout.mileage)")
        print("cals : \(previousWorkout.calorie)")
        print("mins : \(previousWorkout.minute)")
        print("dates : \(previousWorkout.workoutDate)")
        print("new sneaks : \(previousWorkout.newSneaksDate)")
        
        ref.updateChildValues([workoutID: ["miles": previousWorkout.mileage, "calories": previousWorkout.calorie, "minutes": previousWorkout.minute, "dates": previousWorkout.workoutDate, "dateNewSneaks": previousWorkout.newSneaksDate]])
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
                        completion(previousWorkouts)
                    }
                }
            }
        })
    }
}
