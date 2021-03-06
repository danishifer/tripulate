//
//  Expense+CoreDataProperties.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//
//

import CoreData

extension CDExpense {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExpense> {
        return NSFetchRequest<CDExpense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var categoryId: String
    @NSManaged public var trip: CDTrip?
    @NSManaged public var date: Date

}
