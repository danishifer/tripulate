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
    
    public func getTrips(sortedBy: Trip.Sort, ascending: Bool) -> [Trip] {
        let request: NSFetchRequest<CDTrip> = CDTrip.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: sortedBy.rawValue, ascending: ascending)
        ]
        
        do {
            let results = try context.fetch(request)
            return results.map { (trip: CDTrip) -> Trip in
                return trip.toStandardTrip()
            }
        } catch {
            print("[Tripulate] [CoreDataStore] Cannot fetch trips: \(error)")
            return []
        }
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
    
    public func getCDTrip(byID id: String) -> CDTrip? {
        guard
            let idURL = URL(string: id),
            let coordinator = context.persistentStoreCoordinator,
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idURL)
            else {
                print("Cannot get CDTrip with id \(id)")
                return nil
        }
        
        return context.object(with: managedObjectID) as? CDTrip
    }
    
    public func getTrip(byID id: String) -> Trip? {
        return self.getCDTrip(byID: id)?.toStandardTrip()
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
    
    public func getExpenses(ofTrip trip: Trip, sortedBy: Expense.Sort, ascending: Bool) -> [Expense] {
        guard let tripID = trip.id else {
            print("[Tripulate] [CoreDataStore] [getExpenses] trip.id is nil")
            return []
        }
        
        let cdTrip = self.getCDTrip(byID: tripID)
        
        guard let cdExpenses = cdTrip?.expenses else {
            return []
        }
        
        return (try? cdExpenses.sortedArray(
            using: [
            NSSortDescriptor(key: sortedBy.rawValue, ascending: ascending)
        ]).map { (e) -> Expense in
            guard let cdExpense = e as? CDExpense else {
                throw CoreDataStoreError.invalidRelationship
            }
            return cdExpense.toStandardExpense()
        }) ?? []
        
    }
    
    public func addExpense(_ expense: Expense, toTrip trip: Trip) throws -> String {
        guard let tripID = trip.id else {
            print("[Tripulate] [CoreDataStore] [addExpense] trip.id is nil")
            throw CoreDataStoreError.noIDFound
        }
        
        guard let trip = self.getCDTrip(byID: tripID) else {
            print("[Tripulate] [CoreDataStore] [addExpense] CDTrip not found")
            throw CoreDataStoreError.objectNotFound
        }
        
        
        let cdExpense = CDExpense(fromStandardExpense: expense, context: context)
        trip.addToExpenses(cdExpense)
        
        do {
            try context.save()
        } catch {
            print("[Tripulate] [CoreDataStore] [addExpense] couldn't save context \(error)")
            throw CoreDataStoreError.saveFailed(error)
        }
        
        return cdExpense.objectID.uriRepresentation().absoluteString
    }
}

