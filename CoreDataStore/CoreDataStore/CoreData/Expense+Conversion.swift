//
//  CDExpense+Conversion.swift
//  Tripulate
//
//  Created by Dani Shifer on 23/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import CoreData

extension CDExpense {
    func toStandardExpense() -> Expense {
        return Expense(
            id: self.objectID.uriRepresentation().absoluteString,
            creationDate: self.date,
            amount: self.amount,
            name: self.name ?? "",
            categoryId: self.categoryId
        )
    }
    
    convenience init(fromStandardExpense expense: Expense, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = expense.name
        self.amount = expense.amount
        self.categoryId = expense.categoryId
        self.date = expense.creationDate
    }
}
