//
//  Category+CoreDataProperties.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//
//

import CoreData

extension CDExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExpenseCategory> {
        return NSFetchRequest<CDExpenseCategory>(entityName: "ExpenseCategory")
    }

    @NSManaged public var icon: UIImage
    @NSManaged public var internalName: String
    @NSManaged public var displayName: String

}
