//
//  DataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public protocol DataStore {
    func addTrip(_ trip: Trip) throws -> String
    func getTrip(byID id: String) -> Trip?
    func getExpenseCategories() -> [ExpenseCategory]
}


