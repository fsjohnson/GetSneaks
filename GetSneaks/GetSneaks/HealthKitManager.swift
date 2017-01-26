//
//  HealthKitManager.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/25/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitManager: UIView {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(with completion: @escaping (Bool, Error?) -> Void) {
        guard let readType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning) else { print("error retriving read data"); return }
        guard let writeType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning) else { print("error retriving read data"); return }
        let healthDataToRead = Set(arrayLiteral: readType)
        let healthDataToWrite = Set(arrayLiteral: writeType)
        
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { (success, error) in
            if success {
                self.getDistance(with: { (mostRecentDistance, error) in
                    if error != nil {
                        print("MOST RECENT DISTANCE: \(mostRecentDistance)")
                    }
                })
                completion(success, error)
            }
        }
    }
    
    func saveDistance(distanceRecorded: Double, date: Date) {
        guard let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else { print("error retrieving distance type"); return }
        let distanceQuantity = HKQuantity(unit: HKUnit.mile(), doubleValue: distanceRecorded)
        let distance = HKQuantitySample(type: distanceType, quantity: distanceQuantity, start: date as Date, end: date)
        healthKitStore.save(distance) { (success, error) in
            if error != nil {
                print("HEALTH: \(error)")
            } else {
                print("HEALTH: distance recorded successfully")
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
}
