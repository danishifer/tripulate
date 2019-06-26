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

public enum CoreDataStoreError: Error {
    case objectNotFound
    case noIDFound
    case saveFailed(Error)
    case invalidRelationship
}

public class CoreDataStore: DataStore {
    let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func getExpenseCategories() -> [ExpenseCategory] {
        let request: NSFetchRequest<CDExpenseCategory> = CDExpenseCategory.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            return results.map { (category: CDExpenseCategory) -> ExpenseCategory in
                return category.toStandardCategory()
            }
        } catch {
            print("[Tripulate] [CoreDataStore] Couldn't fetch categories: \(error)")
            return []
        }
    }
}

