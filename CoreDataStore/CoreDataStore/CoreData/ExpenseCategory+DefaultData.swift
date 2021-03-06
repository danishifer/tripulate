//
//  Category+DefaultData.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import CoreData
import UIKit

fileprivate struct DefaultCategory: Codable {
    var displayName:  String
    var icon:         String
}

extension CDExpenseCategory {
    fileprivate static func _getDefaultCategories() -> [DefaultCategory] {
        do {
            let path = Bundle.main.path(forResource: "DefaultCategories", ofType: "plist")
            let data = FileManager.default.contents(atPath: path!)
            let defaultCategories = try PropertyListDecoder().decode([DefaultCategory].self, from: data!)
            return defaultCategories
        } catch {
            fatalError("Error getting default categories: \(error)")
        }
    }
    
    public static func insertDefaultData(context: NSManagedObjectContext) {
        let categories = _getDefaultCategories()
        categories.forEach { (data) in
            let category = CDExpenseCategory(context: context)
            category.displayName = data.displayName
            category.icon = UIImage(named: data.icon)!
        }
        
    }
}
