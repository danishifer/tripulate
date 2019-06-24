//
//  Category+Conversion.swift
//  CoreDataStore
//
//  Created by Haim Marcovici on 24/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import TripulateKit

extension CDExpenseCategory {
    func toStandardCategory() -> ExpenseCategory {
        return ExpenseCategory(
            internalName: self.internalName,
            displayName: self.displayName,
            icon: self.icon
        )
    }
}
