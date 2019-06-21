//
//  TripulateDataStore.swift
//  Tripulate
//
//  Created by Dani Shifer on 6/21/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import Foundation

//protocol TripulateDataStore {
//    func getTrips() -> [Trip]
//}

protocol ConfigurationStore {
    func getActiveTrip() -> Trip?
    func setActiveTrip(_ trip: Trip)
}

class UserDefaultsConfigurationStore: ConfigurationStore {
    static let kActiveTripKey = "activeTrip"
    
    func getActiveTrip() -> Trip? {
        return UserDefaults.standard.object(forKey: Self.kActiveTripKey) as? Trip
    }
    
    func setActiveTrip(_ trip: Trip) {
        print("Set active trip")
    }
}

