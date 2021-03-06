//
//  Trip+CoreDataProperties.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//
//

import Foundation
import CoreData


extension CDTrip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTrip> {
        return NSFetchRequest<CDTrip>(entityName: "Trip")
    }

    @NSManaged public var creationDate: Date
    @NSManaged public var budget: Double
    @NSManaged public var currency: String
    @NSManaged public var name: String
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension CDTrip {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: CDExpense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: CDExpense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}
