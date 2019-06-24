//
//  CDExpense+Conversion.swift
//  Tripulate
//
//  Created by Haim Marcovici on 23/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import CoreData

extension CDExpense {
    func asExpense() -> Expense {
        return Expense(
            creationDate: self.date,
            amount: self.amount,
            name: self.name ?? "",
            categoryId: self.categoryId
        )
    }
}
