//
//  ViewController.swift
//  GetSneaks
//
//  Created by Felicity Johnson on 1/12/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import CoreData

class DataModel {
    
    static let sharedInstance = DataModel()
    private let name = "DataModel"
    private init() {}
    var workouts = [Workout]()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: DataModel.sharedInstance.name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Workout Core Data
    func fetchWorkoutData() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        do {
            self.workouts = try managedContext.fetch(fetchRequest)
        } catch {}
    }
    
    func deleteWorkoutData() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        do {
            self.workouts = try context.fetch(fetchRequest)
            for object in workouts {
                context.delete(object)
                try context.save()
            }
        } catch {}
    }
}
