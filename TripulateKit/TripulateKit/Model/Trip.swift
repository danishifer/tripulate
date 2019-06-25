//
//  Trip.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI

public struct Trip: Codable, Identifiable {
    public var id: String? {
        get {
            return self.persistentID
        }
    }
    
    public var persistentID: String?
    public var creationDate: Date
    public var name: String
    public var budget: Double
    public var currency: String
    public var expenses: [Expense]

    public init(
        persistentID: String? = nil,
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
        self.persistentID = persistentID
    }
}


extension Trip {
    public enum Sort: String {
        case creationDate = "creationDate"
    }
}
