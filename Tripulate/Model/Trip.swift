//
//  Trip.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/22/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

struct Trip: Codable {
    var creationDate: Date = .init()
    var name: String
    var budget: Double
    var currency: String
    var expenses: [Expense] = []
    
}
