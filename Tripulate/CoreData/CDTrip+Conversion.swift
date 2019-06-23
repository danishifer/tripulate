//
//  CDTrip+Conversion.swift
//  Tripulate
//
//  Created by Haim Marcovici on 23/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import CoreData

extension CDTrip {
    func asTrip() -> Trip {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        
        let trip = Trip(
            name: self.name,
            budget: self.budget,
            currency: self.currency,
            expenses: self.expenses?.map({ (e) -> Expense in
                guard let expense = e as? CDExpense else {
                    fatalError("Property does not conform to CDExpense")
                }
                return expense.asExpense()
                
            }) ?? []
        )
        
        return trip
    }
}
