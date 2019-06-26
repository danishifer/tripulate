//
//  DataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public protocol DataStore {
    // MARK: - Trip
    func getTrips(sortedBy: Trip.Sort, ascending: Bool, completion callback: @escaping ([Trip]) -> Void)
    func addTrip(_ trip: Trip) throws -> String
    func getTrip(byID id: String) -> Trip?
    
    func getTripsSync(sortedBy: Trip.Sort, ascending: Bool) -> [Trip]
    
    // MARK: - ExpenseCategory
    func getExpenseCategories() -> [ExpenseCategory]
    
    
    // MARK: - Expense
    func addExpense(_ expense: Expense, toTrip trip: Trip) throws -> String
    func getExpenses(ofTrip trip: Trip, sortedBy: Expense.Sort, ascending: Bool) -> [Expense]
    func removeExpense(_ expense: Expense) throws
}
