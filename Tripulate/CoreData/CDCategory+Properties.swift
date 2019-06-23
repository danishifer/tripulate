//
//  Category+CoreDataProperties.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "Category")
    }

    @NSManaged public var icon: UIImage?
    @NSManaged public var internalName: String?
    @NSManaged public var displayName: String?

}
