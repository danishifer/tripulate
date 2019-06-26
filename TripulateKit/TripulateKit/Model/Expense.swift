//
//  Expense.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI

public struct Expense: Codable, Identifiable, Hashable {
    public var id: String?
    public let creationDate: Date
    public var amount: Double
    public var name: String?
    public var categoryId: String
    
    public init(id: String?, creationDate: Date, amount: Double, name: String?, categoryId: String) {
        self.id = id
        self.creationDate = creationDate
        self.amount = amount
        self.name = name
        self.categoryId = categoryId
    }
}

extension Expense {
    public enum Sort: String {
        case creationDate = "date"
    }
}
