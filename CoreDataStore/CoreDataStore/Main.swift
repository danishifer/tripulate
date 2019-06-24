//
//  Main.swift
//  CoreDataStore
//
//  Created by Dani Shifer on 24/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import CoreData

public let CoreDataStoreBundleID = "com.danishifer.CoreDataStore"

public class CoreDataStore: DataStore {
    let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        print(Bundle.main.bundleIdentifier ?? "")
    }
    
    public func addTrip(_ trip: Trip) throws -> String {
        let cdTrip = CDTrip(context: context)
        cdTrip.creationDate = trip.creationDate
        cdTrip.name = trip.name
        cdTrip.budget = trip.budget
        cdTrip.currency = trip.currency
        try context.save()
        return cdTrip.objectID.uriRepresentation().absoluteString
    }
    
    public func getTrip(byID id: String) -> Trip? {
        guard
            let idURL = URL(string: id),
            let coordinator = context.persistentStoreCoordinator,
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idURL),
            let cdTrip = context.object(with: managedObjectID) as? CDTrip
            else {
                print("Cannot get trip with id \(id)")
                return nil
        }
        
        return cdTrip.toStandardTrip()
    }
    
    public func getExpenseCategories() -> [ExpenseCategory] {
        let request: NSFetchRequest<CDExpenseCategory> = CDExpenseCategory.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            return results.map { (category: CDExpenseCategory) -> ExpenseCategory in
                return category.toStandardCategory()
            }
        } catch {
            print("[Tripulate] [CoreDataStore] Cannot fetch categories: \(error)")
            return []
        }
    }
}

