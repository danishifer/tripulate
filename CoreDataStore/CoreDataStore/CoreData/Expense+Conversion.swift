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
            creationDate: self.date,
            amount: self.amount,
            name: self.name ?? "",
            categoryId: self.categoryId
        )
    }
}
