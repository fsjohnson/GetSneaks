//
//  HealthKitManager.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/25/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit
import HealthKit
import CoreData

class HealthKitManager: UIView {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    var distance = Double()
    var calories = Double()
    let date = Date()
    var energyFormatter = EnergyFormatter()
    var duration = Double()
    let dateFormatter = DateFormatter()
    
    var startDate: Date? {
        get {
            return datetimeWithDate(date: date, time: date )
        }
    }
    
    func datetimeWithDate(date: Date , time: Date) -> Date? {
        let currentCalendar = NSCalendar.current
        let dateUnits: Set<Calendar.Component> = [.day, .month, .year]
        let timeUnits: Set<Calendar.Component> = [.hour, .minute]
        let dateComponents = Calendar.current.dateComponents(dateUnits, from: date)
        let hourComponents = Calendar.current.dateComponents(timeUnits, from: date)
        guard let components = currentCalendar.date(from: dateComponents) else { print("error calc date with time"); return nil }
        let dateWithTime = Calendar.current.date(byAdding: hourComponents, to: components)
        return dateWithTime
    }
    
    func authorizeHealthKit(with completion: @escaping (Bool, Error?) -> Void) {
        let readType: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, HKObjectType.workoutType()]
        let writeType: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, HKObjectType.workoutType()]
        
        
        healthKitStore.requestAuthorization(toShare: writeType, read: readType) { (success, error) in
            if success {
                self.getDistance(with: { (mostRecentDistance, error) in
                    print("ERROR: \(error)")
                    if error == nil {
                        let distance = mostRecentDistance as? HKQuantitySample
                        if let miles = distance?.quantity.doubleValue(for: HKUnit.mile()) {
                            guard let distanceDouble = Double(String(format: "%.3f", miles)) else { print("error retrieving distance double in authorizeHealthKit"); return }
                            self.distance = distanceDouble.roundTo(places: 2)
                            print("MILES: \(self.distance)")
                        }
                        self.getCalories(with: { (recentCals, error) in
                            if error == nil {
                                let totalCals = recentCals as? HKQuantitySample
                                if let cals = totalCals?.quantity.doubleValue(for: HKUnit.calorie()) {
                                    self.calories = cals
                                    print("CALS: \(self.calories)")
                                }
                            }
                        })
                        completion(success, error)
                    }
                })
            }
        }
    }
    
    func getDistance(with completion: @escaping (HKStatistics?, Error?) -> Void) {
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { print("error retrieving distance type"); return }
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let beginningOfDay = cal.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: beginningOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query: HKStatisticsQuery, results: HKStatistics?, error: Error?) in
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            if let results = results {
                print("result: \(results.sumQuantity()?.doubleValue(for: HKUnit.mile()))")
                completion(results, error)
            }
        }
        self.healthKitStore.execute(query)
    }
    
    func getCalories(with completion: @escaping (Double?, Error?) -> Void) {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { print("error retrieving energy type"); return }
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let beginningOfDay = cal.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: beginningOfDay, end: now, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: energyType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            let mostRecentSample = results?.first as? HKQuantitySample
            let activeEnergy = mostRecentSample?.quantity.doubleValue(for: HKUnit.calorie())
            print(activeEnergy)
            completion(activeEnergy, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }
    
    func getExerciseTime(with completion: @escaping (HKSample?, Error?) -> Void) {
        guard let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else { print("error retrieving exercise type"); return }
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let beginningOfDay = cal.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: beginningOfDay, end: now, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: exerciseType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            let mostRecentSample = results?.first as? HKQuantitySample
            print("MOST RECENT EXERCISE: \(mostRecentSample)")
            completion(mostRecentSample, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }
    
    
    func getWorkout(with completion: @escaping ([AnyObject]?, Error?) -> Void) {
        print("GET WORKOUT CALLED")
        let predicate = HKQuery.predicateForWorkouts(with: HKWorkoutActivityType.running)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: HKWorkoutType.workoutType(), predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            print("RESULTS: \(results)")
            if let queryError = error {
                print("QUERY ERROR: \(queryError)")
                completion(nil, queryError)
                return
            }
            completion(results, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }
    
    func saveWorkout(startDate: Date, endDate: Date, distance: Double, distanceUnit: HKUnit, calories: Double, minutesDuration: Double, completion: @escaping (Bool, Error?) -> Void) {
        let distanceQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
        let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let workout = HKWorkout(activityType: .running, start: startDate, end: endDate, duration: minutesDuration, totalEnergyBurned: caloriesQuantity, totalDistance: distanceQuantity, metadata: nil)
        healthKitStore.save(workout, withCompletion: { (success, error) -> Void in
            if error !=  nil {
                print("Error saving workout: \(error)")
                completion(success, error)
            } else {
                print("Succes: workout saved: \(workout)")
                let managedContext = DataModel.sharedInstance.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
                
                print("MILES \(distance)")
                print("cals \(calories)")
                print("duration \(minutesDuration)")
                
                if let unwrappedEntity = entity {
                    let newWorkout = Workout(context: managedContext)
                    newWorkout.mileage = String(describing: distance)
                    newWorkout.calorie = String(describing: calories)
                    newWorkout.minute = String(describing: minutesDuration)
                    newWorkout.workoutDate = self.dateFormatter.string(from: Date())
                    DataModel.sharedInstance.saveContext()
                }
                completion(success, nil)
            }
        })
    }
    
    func saveHealthKitData(startDate: Date, endDate: Date, distance: Double, distanceUnit: HKUnit, calories: Double, minutesDuration: Double) {
        print("SAVE DATA")
        saveWorkout(startDate: startDate, endDate: Date(), distance: distance, distanceUnit: HKUnit.mile(), calories: calories, minutesDuration: minutesDuration) { (success, error) in
            if success {
                print("success")
                let managedContext = DataModel.sharedInstance.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
                
                print("MILES \(self.distance)")
                print("cals \(self.calories)")
                print("duration \(minutesDuration)")
                
                if let unwrappedEntity = entity {
                    let newWorkout = Workout(context: managedContext)
                    newWorkout.mileage = String(describing: self.distance)
                    newWorkout.calorie = String(describing: self.calories)
                    newWorkout.minute = String(describing: minutesDuration)
                    newWorkout.workoutDate = self.dateFormatter.string(from: Date())
                    DataModel.sharedInstance.saveContext()
                }
            } else {
                print("ERROR: \(error)")
            }
        }
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
