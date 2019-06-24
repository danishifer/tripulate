//
//  Trip.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public struct Trip: Codable {
    public var creationDate: Date
    public var name: String
    public var budget: Double
    public var currency: String
    public var expenses: [Expense]

    public init(
        creationDate: Date = .init(),
        name: String,
        budget: Double,
        currency: String,
        expenses: [Expense] = []
    ) {
        self.name = name
        self.budget = budget
        self.currency = currency
        self.expenses = expenses
        self.creationDate = creationDate
    }
}
