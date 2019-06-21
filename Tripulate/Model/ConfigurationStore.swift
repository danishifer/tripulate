//
//  TripulateDataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

protocol ConfigurationStore {
    var activeTripID: String? { get set }
}

class UserDefaultsConfigurationStore: ConfigurationStore {
    static let kActiveTripIDKey = "activeTripID"
    
    var activeTripID: String? {
        get {
            return UserDefaults.standard.string(forKey: Self.kActiveTripIDKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Self.kActiveTripIDKey)
        }
    }
    
}

