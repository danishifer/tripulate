//
//  Category.swift
//  TripulateKit
//
//  Created by Haim Marcovici on 24/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public struct ExpenseCategory {
    public var icon: UIImage
    public var internalName: String
    public var displayName: String
    
    public init(internalName: String, displayName: String, icon: UIImage) {
        self.internalName = internalName
        self.displayName = displayName
        self.icon = icon
    }
}
