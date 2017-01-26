//
//  HealthManager.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/26/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealthManager {
    let healthKitStore: HKHealthStore = HKHealthStore()
    var distance = Double()
    
    static func authorizeHealthKit(with completion: @escaping (Bool, Error?) -> Void) {
        guard let readType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning) else { print("error retriving read data"); return }
        guard let writeType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning) else { print("error retriving read data"); return }
        let healthDataToRead = Set(arrayLiteral: readType)
        let healthDataToWrite = Set(arrayLiteral: writeType)
        
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { (success, error) in
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
    
    func saveWorkout(startDate: Date, endDate: Date, distance: Double, distanceUnit: HKUnit, calories: Double, completion: @escaping (Bool, Error?) -> Void) {
        let distanceQuantity = HKQuantity(unit: distanceUnit, doubleValue: distance)
        let caloriesQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: calories)
        let workout = HKWorkout(activityType: .running, start: startDate, end: endDate, duration: abs(endDate.timeIntervalSince(startDate)), totalEnergyBurned: caloriesQuantity, totalDistance: distanceQuantity, metadata: nil)
        healthKitStore.save(workout, withCompletion: { (success, error) -> Void in
            if error !=  nil {
                print("Error saving workout: \(error)")
                completion(success, error)
            } else {
                print("Succes: workout saved")
                completion(success, nil)
            }
        })
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
