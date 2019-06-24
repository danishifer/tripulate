//
//  Main.swift
//  UserDefaultsConfigurationStore
//
//  Created by Haim Marcovici on 24/06/2019.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import TripulateKit
import Combine

public class UserDefaultsConfigurationStore: ConfigurationStore {
    static let kActiveTripIDKey = "activeTripID"
    
    public init() {}
    
    public var activeTripID: String? {
        get {
            return UserDefaults.standard.string(forKey: Self.kActiveTripIDKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Self.kActiveTripIDKey)
            NotificationCenter.default.post(name: .activeTripDidChange, object: nil)
        }
    }
}
