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

class HealthKitManager: UIView {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    var distance = Double()
    var calories = Double()
    let date = Date()
    
    var startDate: Date? {
        get {
            return datetimeWithDate(date: date, time: date )
        }
    }
    
    //    var durationInMinutes: Double {
    //        get {
    //            return durationTimeCell.doubleValue
    //        }
    //    }
    
    //    var energyBurned: Double? {
    //        return caloriesCell.doubleValue
    //
    //    }
    
    func datetimeWithDate(date: Date , time: Date) -> Date? {
        
        let currentCalendar = NSCalendar.current
        let dateUnits: Set<Calendar.Component> = [.day, .month, .year]
        let timeUnits: Set<Calendar.Component> = [.hour, .minute]
        let dateComponents = Calendar.current.dateComponents(dateUnits, from: date)
        let hourComponents = Calendar.current.dateComponents(timeUnits, from: date)
        
        let dateWithTime = Calendar.current.date(byAdding: hourComponents, to: currentCalendar.date(from: dateComponents)!)
        
        return dateWithTime;
    }
    
    func authorizeHealthKit(with completion: @escaping (Bool, Error?) -> Void) {
        let readType: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        let writeType: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!, HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!]
        
        
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
                        self.getCalories(with: { (mostRecentCalories, error) in
                            let energyBurned = mostRecentCalories as? HKQuantitySample
                            if let unwrappedCalories = energyBurned?.quantity.doubleValue(for: HKUnit.calorie()) {
                                self.calories = unwrappedCalories
                                print("CALORIES: \(self.calories)")
                            }
                            
                        })
                    }
                    completion(success, error)
                })
            }
        }
    }
    
    func getDistance(with completion: @escaping (HKSample?, Error?) -> Void) {
        print("GET DISTANCE CALLED")
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { print("error retrieving distance type"); return }
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let beginningOfDay = cal.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: beginningOfDay, end: now, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: distanceType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let queryError = error {
                completion(nil, queryError)
                return
            }
            let mostRecentSample = results?.first as? HKQuantitySample
            print("MOST RECENT SAMPLE: \(mostRecentSample)")
            completion(mostRecentSample, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }
    
    func getCalories(with completion: @escaping (HKSample?, Error?) -> Void) {
        print("GET CALORIES CALLED")
        guard let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { print("error retrieving energy burned type"); return }
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let beginningOfDay = cal.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: beginningOfDay, end: now, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: energyBurnedType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let queryError = error {
                print("QUERY ERROR: \(queryError)")
                completion(nil, queryError)
                return
            }
            let mostRecentSample = results?.first as? HKQuantitySample
            print("MOST RECENT SAMPLE: \(mostRecentSample)")
            completion(mostRecentSample, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }

    func getWorkout(with completion: @escaping (HKSample?, Error?) -> Void) {
        print("GET WORKOUT CALLED")
        let predicate = HKQuery.predicateForWorkouts(with: HKWorkoutActivityType.running)
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let sampleQuery = HKSampleQuery(sampleType: HKWorkoutType.workoutType(), predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            if let queryError = error {
                print("QUERY ERROR: \(queryError)")
                completion(nil, queryError)
                return
            }
            let mostRecentSample = results?.first as? HKQuantitySample
            print("MOST RECENT SAMPLE: \(mostRecentSample)")
            completion(mostRecentSample, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }
    
    func saveWorkout(startDate: Date, endDate: Date, distance: Double, distanceUnit: HKUnit, calories: Double, completion: @escaping (Bool, Error?) -> Void) {
        let distanceQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
        let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let workout = HKWorkout(activityType: .running, start: startDate, end: endDate, duration: abs(endDate.timeIntervalSince(startDate)), totalEnergyBurned: caloriesQuantity, totalDistance: distanceQuantity, metadata: nil)
        healthKitStore.save(workout, withCompletion: { (success, error) -> Void in
            if error !=  nil {
                print("Error saving workout: \(error)")
                completion(success, error)
            } else {
                print("Succes: workout saved: \(workout)")
                completion(success, nil)
            }
        })
    }
    
    func saveHealthKitData() {
        print("SAVE DATA")
        saveWorkout(startDate: startDate!, endDate: Date(), distance: distance, distanceUnit: HKUnit.mile(), calories: calories) { (success, error) in
            if success {
                print("success")
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
