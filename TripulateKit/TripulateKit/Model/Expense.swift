//
//  Expense.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public struct Expense: Codable {
    public let creationDate: Date
    public var amount: Double
    public var name: String
    public var categoryId: String
    
    public init(creationDate: Date, amount: Double, name: String, categoryId: String) {
        self.creationDate = creationDate
        self.amount = amount
        self.name = name
        self.categoryId = categoryId
    }
}
