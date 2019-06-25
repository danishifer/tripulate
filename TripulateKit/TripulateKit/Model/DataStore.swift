//
//  DataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public protocol DataStore {
    // MARK: Trip
    func getTrips(sortedBy: Trip.Sort, ascending: Bool) -> [Trip]
    func addTrip(_ trip: Trip) throws -> String
    func getTrip(byID id: String) -> Trip?
    
    // MARK: Category
    func getExpenseCategories() -> [ExpenseCategory]
    
    // MARK: Expense
    func getExpenses(ofTrip trip: Trip, sortedBy: Expense.Sort, ascending: Bool) -> [Expense]
    func addExpense(_ expense: Expense, toTrip trip: Trip) throws -> String
}


extension DataStore {
    public func getTrips(sortedBy: Trip.Sort, ascending: Bool = false) -> [Trip] {
        return self.getTrips(sortedBy: sortedBy, ascending: ascending)
    }
    
    public func getExpenses(ofTrip trip: Trip, sortedBy: Expense.Sort, ascending: Bool = false) -> [Expense] {
        return self.getExpenses(ofTrip: trip, sortedBy: sortedBy, ascending: ascending)
    }
}
