//
//  CDTrip+Conversion.swift
//  Tripulate
//
//  Created by Dani Shifer on 23/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import CoreData


extension CDTrip {
    func toStandardTrip() -> Trip {
        let trip = Trip(
            creationDate: self.creationDate,
            name: self.name,
            budget: self.budget,
            currency: self.currency,
            expenses: self.expenses?.map({ (e) -> Expense in
                guard let expense = e as? CDExpense else {
                    fatalError("Property does not conform to CDExpense")
                }
                return expense.toStandardExpense()
                
            }) ?? []
        )
        
        return trip
    }
}
