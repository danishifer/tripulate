//
//  Currency.swift
//  Tripulate
//
//  Created by Dani Shifer on 18/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

public class Currency: Codable {
    public let code: String
    public let displayName: String
    public let symbol: String
    public let useSpace: Bool
}
