//
//  Currency+DefaultData.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

extension Currency {
    fileprivate static func getDefaultCurrencies() -> [Currency] {
        do {
            let path = Bundle.main.path(forResource: "Currencies", ofType: "plist")
            let data = FileManager.default.contents(atPath: path!)
            let defaultCategories = try PropertyListDecoder().decode([Currency].self, from: data!)
            return defaultCategories
        } catch {
            fatalError("Error getting default categories: \(error)")
        }
    }
    
    public static var all: [Currency] = Currency.getDefaultCurrencies()
    
    public static func from(code: String) -> Currency? {
        return Currency.all.first { (currency: Currency) -> Bool in
            return currency.code == code
        }
    }
}
