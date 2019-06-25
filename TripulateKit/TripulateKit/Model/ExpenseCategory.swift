//
//  Category.swift
//  TripulateKit
//
//  Created by Dani Shifer on 24/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import SwiftUI

public struct ExpenseCategory: Identifiable {
    public var id: String?
    public var icon: UIImage
    public var displayName: String
    
    public init(id: String? = nil, displayName: String, icon: UIImage) {
        self.id = id
        self.displayName = displayName
        self.icon = icon
    }
}
