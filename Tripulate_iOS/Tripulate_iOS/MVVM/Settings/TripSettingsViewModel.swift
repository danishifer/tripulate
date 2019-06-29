//
//  TripSettingsViewModel.swift
//  Tripulate_iOS
//
//  Created by Dani Shifer on 6/29/19.
//  Copyright © 2019 Dani Shifer. All rights reserved.
//

import SwiftUI
import Combine
import TripulateKit

class TripSettingsViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    let configurationStore: ConfigurationStore
    let dataStore: DataStore
    
    init(configurationStore: ConfigurationStore, dataStore: DataStore) {
        self.configurationStore = configurationStore
        self.dataStore = dataStore
        
        self.name = self.trip?.name ?? ""
    }
    
    private func getActiveTrip() -> Trip? {
        guard let activeTripId = configurationStore.activeTripID else {
            return nil
        }
        
        return dataStore.getTrip(byID: activeTripId)
    }
    
    lazy var trip: Trip? = self.getActiveTrip()
    
    var name: String = "" {
        didSet {
            self.didChange.send(())
        }
    }
}
