//
//  CoreDataStore+Expense.swift
//  CoreDataStore
//
//  Created by Dani Shifer on 6/26/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import CoreData
import TripulateKit

extension CoreDataStore {
    func getCDExpense(byID id: String) -> CDExpense? {
        guard
            let idURL = URL(string: id),
            let coordinator = context.persistentStoreCoordinator,
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: idURL)
            else {
                print("[Tripulate] [CoreDataStore] [getCDExpense] Cannot get CDExpense with id \(id)")
                return nil
        }
        
        return context.object(with: managedObjectID) as? CDExpense
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
    
    public func removeExpense(_ expense: Expense) throws {
        guard let expenseID = expense.id else {
            print("[Tripulate] [CoreDataStore] [removeExpense] expense.id is nil")
            throw CoreDataStoreError.noIDFound
        }
        
        guard let cdExpense = getCDExpense(byID: expenseID) else {
            throw CoreDataStoreError.objectNotFound
        }
        
        context.delete(cdExpense)
        
        return try context.save()
    }
}
