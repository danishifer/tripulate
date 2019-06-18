//
//  Category+DefaultData.swift
//  Tripulate
//
//  Created by Haim Marcovici on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

fileprivate struct DefaultCategory: Codable {
    var displayName:  String
    var internalName: String
    var icon:         String
}

extension Category {
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
            let category = Category(context: context)
            category.internalName = data.internalName
            category.displayName = data.displayName
            category.icon = UIImage(named: data.icon)
        }
        
    }
}
