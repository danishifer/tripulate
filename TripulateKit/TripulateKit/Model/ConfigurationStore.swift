//
//  TripulateDataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation
import Combine

public protocol ConfigurationStore {
    var activeTripID: String? { get set }
}

extension Notification.Name {
    public static let activeTripDidChange = Notification.Name("activeTripDidChange")
}
